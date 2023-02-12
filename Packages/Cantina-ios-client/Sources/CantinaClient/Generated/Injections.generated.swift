// Generated using Sourcery 2.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import Foundation
import Foundation
import Combine
import CombineMoya
import Foundation
import Moya


// MARK: - CatalogRepositoryInjection

final class CatalogRepositoryInjectionImpl: CatalogRepositoryInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var restClient: RestApiClient {
        injector.restClient
    }
}

extension ClientModule {
    func build() -> CatalogRepositoryInjection {
        CatalogRepositoryInjectionImpl(injector: self)
    }
}
// MARK: - ContactRepositoryInjection

final class ContactRepositoryInjectionImpl: ContactRepositoryInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var restClient: RestApiClient {
        injector.restClient
    }
}

extension ClientModule {
    func build() -> ContactRepositoryInjection {
        ContactRepositoryInjectionImpl(injector: self)
    }
}
// MARK: - HomeRepositoryInjection

final class HomeRepositoryInjectionImpl: HomeRepositoryInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var restClient: RestApiClient {
        injector.restClient
    }
}

extension ClientModule {
    func build() -> HomeRepositoryInjection {
        HomeRepositoryInjectionImpl(injector: self)
    }
}
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
