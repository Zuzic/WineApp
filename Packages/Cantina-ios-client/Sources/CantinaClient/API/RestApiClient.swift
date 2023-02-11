import Combine
import CombineMoya
import Foundation
import Moya

public typealias DefaultResultClosure = (Result<Void, Error>) -> Void
typealias ParamDictionary = [String: Any]
typealias RestCancellable = Moya.Cancellable

private final class MoyaLoggerPlugin: Moya.PluginType {
    func willSend(_ request: RequestType, target _: TargetType) {
        _ = request.cURLDescription { value in
            Logger.rest.verbose("Request: \(value)")
        }
    }

    func didReceive(_ result: Result<Moya.Response, MoyaError>, target _: TargetType) {
        switch result {
        case .success(let response):
            guard let url = response.request?.url else { return }

            if response.data.isEmpty == false, let dataString = String(data: response.data, encoding: .utf8) {
                Logger.rest.verbose("Response: \(url) code: \(response.statusCode) data:\n\(dataString)")
            } else {
                Logger.rest.verbose("Response: \(url) code: \(response.statusCode)")
            }
        case .failure(let error):
            Logger.rest.error("Response: \(error)")
        }
    }
}

// sourcery: builder
protocol RestApiClientInjection {
    var settings: ClientModuleSettings { get }
}

final class RestApiClient: MoyaProvider<DynamicTarget<RestApiRouter>> {
    typealias RefreshRequestClosure = (@escaping DefaultResultClosure) -> Void
    private let queue = DispatchQueue(label: "com.zuzic.core.rest")
    private let injection: RestApiClientInjection

    init(injection: RestApiClientInjection) {
        self.injection = injection
        super.init(plugins: [MoyaLoggerPlugin()])
    }

    func asyncPerform(route: RestApiRouter) async throws {
        try await perform(route: route).decodeResponse(type: EmptyResponse.self).async()
    }

    func asyncPerform<T: Decodable>(route: RestApiRouter) async throws -> T {
        try await perform(route: route).decodeResponse(type: T.self).async()
    }

    func perform(route: RestApiRouter) -> AnyPublisher<Data, Error> {
        let baseURL = RestInfo.ProductionServer.preparedBaseURL(at: injection.settings.restEndpoint)
        let dynamicRoute = DynamicTarget(baseURL: baseURL, target: route)
        return requestPublisher(dynamicRoute, callbackQueue: queue)
            .mapError { $0 as Error }
            .flatMap { response -> AnyPublisher<Data, Error> in
                switch response.statusCode {
                case 401:
                    return Future { promise in
                        promise(.failure(RestError.invalidToken))
                    }.eraseToAnyPublisher()
                case 200 ..< 300, 400 ..< 500:
                    return Future { promise in
                            promise(.success(response.data))
                    }.eraseToAnyPublisher()
                default:
                    let resultError = NSError.serverError(url: response.request?.url,
                                                          statusCode: response.statusCode)
                    return Future { promise in
                        promise(.failure(resultError))
                    }.eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
