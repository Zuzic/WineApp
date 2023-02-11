// Generated using Sourcery 2.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Combine
import CombineMoya
import Foundation
import Moya


// MARK: - RestApiClientInjection

final class RestApiClientInjectionImpl: RestApiClientInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var settings: ClientModuleSettings {
        injector.clientModuleDependencySettings
    }
}

extension ClientModule {
    func build() -> RestApiClientInjection {
        RestApiClientInjectionImpl(injector: self)
    }
}
