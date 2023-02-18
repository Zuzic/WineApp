import Foundation
// sourcery:inline:Injector.ModuleImports
import CantinaClient

// sourcery:end
import StreamsCommon

final class Injector {
    // sourcery:inline:Injector.ModuleDefenition
    @LazyAtomic private(set) var clientModuleOutput: ClientModuleOutput
   
    // sourcery:end

    static let injector = Injector()

    let settings = Settings()

    private init() {
        // sourcery:inline:Injector.ModuleInitialization
        _clientModuleOutput.initializer = { [unowned self] in ClientModule(injection: build()) }
      
        // sourcery:end
    }
}

// sourcery:inline:Injector.UnwrapModuleOutputs
// swiftlint: disable: identifier_name
extension Injector {
    // MARK: - ClientModuleOutput
    var clientModuleOutputCatalogRepository: CantinaClient.CatalogRepository { clientModuleOutput.catalogRepository }
    var clientModuleOutputHomeRepository: CantinaClient.HomeRepository { clientModuleOutput.homeRepository }
    var clientModuleOutputContactRepository: CantinaClient.ContactRepository { clientModuleOutput.contactRepository }
    var clientModuleOutputInitialRepository: CantinaClient.InitialRepository { clientModuleOutput.initialRepository }
    var clientModuleOutputWineStatusRepository: CantinaClient.WineStatusRepository { clientModuleOutput.wineStatusRepository }

}
// sourcery:end
