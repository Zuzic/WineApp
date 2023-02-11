import Combine
import Foundation

extension AnyPublisher where Failure == Error, Output == Data {
    func decodeResponse<T: Decodable>(type: T.Type) -> AnyPublisher<T, AuthResponseError> {
        return mapError { AuthResponseError.unknown($0.localizedDescription) }
            .flatMap { data -> AnyPublisher<T, AuthResponseError> in
                if type == EmptyResponse.self,
                   data.isEmpty,
                   let tObject = EmptyResponse() as? T
                {
                    return Future { promise in
                        promise(.success(tObject))
                    }.eraseToAnyPublisher()
                } else if type != EmptyResponse.self,
                          let tObject = try? JSONDecoder().decode(T.self, from: data)
                {
                    return Future { promise in
                        promise(.success(tObject))
                    }.eraseToAnyPublisher()
                } else {
                    return Future { promise in
                        promise(.failure(AuthResponseError.unknown("")))
                    }.eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

public extension AnyPublisher {
    @discardableResult
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?

            cancellable = first().sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
                cancellable?.cancel()
            } receiveValue: { value in
                continuation.resume(with: .success(value))
            }
        }
    }
}
