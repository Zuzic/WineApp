// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
import Foundation
import Foundation
import Foundation
import Combine
import CombineMoya
import Foundation
import Moya
import Foundation


// MARK: - CatalogRepositoryInjection

final class CatalogRepositoryInjectionImpl: CatalogRepositoryInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var restClient: RestApiClient {
        injector.restClient
    }

    var storage: Storage {
        injector.storage
    }

    var initialRepository: InitialRepository {
        injector.initialRepository
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

    var storage: Storage {
        injector.storage
    }

    var initialRepository: InitialRepository {
        injector.initialRepository
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

    var storage: Storage {
        injector.storage
    }

    var initialRepository: InitialRepository {
        injector.initialRepository
    }
}

extension ClientModule {
    func build() -> HomeRepositoryInjection {
        HomeRepositoryInjectionImpl(injector: self)
    }
}
// MARK: - InitialRepositoryInjection

final class InitialRepositoryInjectionImpl: InitialRepositoryInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var restClient: RestApiClient {
        injector.restClient
    }

    var storage: Storage {
        injector.storage
    }
}

extension ClientModule {
    func build() -> InitialRepositoryInjection {
        InitialRepositoryInjectionImpl(injector: self)
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
// MARK: - StorageInjection

final class StorageInjectionImpl: StorageInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }
}

extension ClientModule {
    func build() -> StorageInjection {
        StorageInjectionImpl(injector: self)
    }
}
// MARK: - WineStatusRepositoryInjection

final class WineStatusRepositoryInjectionImpl: WineStatusRepositoryInjection {
    private let injector: ClientModule
    fileprivate init(injector: ClientModule) {
        self.injector = injector
    }

    var storage: Storage {
        injector.storage
    }
}

extension ClientModule {
    func build() -> WineStatusRepositoryInjection {
        WineStatusRepositoryInjectionImpl(injector: self)
    }
}
