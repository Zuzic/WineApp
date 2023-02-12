import Foundation
import StreamsCommon

// _sourcery:inline:ClientModule.UnwrapModuleDependencyImports
// _sourcery:end

// sourcery: Module = "CantinaClient"
final public class ClientModule: ClientModuleOutput {
    private let injection: ClientModuleDependency
    
    @LazyAtomic public private(set) var catalogRepository: CatalogRepository
    @LazyAtomic public private(set) var homeRepository: HomeRepository
    @LazyAtomic public private(set) var contactRepository: ContactRepository
    
    @LazyAtomic private(set) var restClient: RestApiClient
    
    public init(injection: ClientModuleDependency) {
        self.injection = injection
        
        _restClient.initializer = { [unowned self] in RestApiClient(injection: build()) }
        _catalogRepository.initializer = { [unowned self] in CatalogRepositoryImpl(injection: build()) }
        _homeRepository.initializer = { [unowned self] in HomeRepositoryImpl(injection: build()) }
        _contactRepository.initializer = { [unowned self] in ContactRepositoryImpl(injection: build()) }
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<ClientModuleDependency, T>) -> T {
        injection[keyPath: keyPath]
    }
}

// _sourcery:inline:ClientModule.UnwrapModuleDependency
// swiftlint: disable: identifier_name
extension ClientModule {
    var clientModuleDependencySettings: ClientModuleSettings { injection.settings }
}
// _sourcery:end
