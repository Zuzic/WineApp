// Generated using Sourcery 1.8.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import CantinaClient
import Combine
import Foundation
import CantinaClient
import Foundation
import CantinaClient
import Foundation
import CantinaClient
import Foundation


// MARK: - AppEnterViewModelInjection

final class AppEnterViewModelInjectionImpl: AppEnterViewModelInjection {
    private let injector: Injector
    fileprivate init(injector: Injector) {
        self.injector = injector
    }

    var catalogRepository: CatalogRepository {
        injector.clientModuleOutput.catalogRepository
    }

    var homeViewModelInjection: HomeViewModelInjection {
        HomeViewModelInjectionImpl(injector: injector)
    }

    var catalogViewModelInjection: CatalogViewModelInjection {
        CatalogViewModelInjectionImpl(injector: injector)
    }

    var contactsViewModelInjection: ContactsViewModelInjection {
        ContactsViewModelInjectionImpl(injector: injector)
    }
}

extension Injector {
    func build() -> AppEnterViewModelInjection {
        AppEnterViewModelInjectionImpl(injector: self)
    }
}
// MARK: - CatalogViewModelInjection

final class CatalogViewModelInjectionImpl: CatalogViewModelInjection {
    private let injector: Injector
    fileprivate init(injector: Injector) {
        self.injector = injector
    }

    var catalogRepository: CatalogRepository {
        injector.clientModuleOutput.catalogRepository
    }
}

extension Injector {
    func build() -> CatalogViewModelInjection {
        CatalogViewModelInjectionImpl(injector: self)
    }
}
// MARK: - ContactsViewModelInjection

final class ContactsViewModelInjectionImpl: ContactsViewModelInjection {
    private let injector: Injector
    fileprivate init(injector: Injector) {
        self.injector = injector
    }

    var contactRepository: ContactRepository {
        injector.clientModuleOutput.contactRepository
    }
}

extension Injector {
    func build() -> ContactsViewModelInjection {
        ContactsViewModelInjectionImpl(injector: self)
    }
}
// MARK: - HomeViewModelInjection

final class HomeViewModelInjectionImpl: HomeViewModelInjection {
    private let injector: Injector
    fileprivate init(injector: Injector) {
        self.injector = injector
    }

    var homeRepository: HomeRepository {
        injector.clientModuleOutput.homeRepository
    }
}

extension Injector {
    func build() -> HomeViewModelInjection {
        HomeViewModelInjectionImpl(injector: self)
    }
}
