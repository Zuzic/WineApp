import Foundation

// sourcery: ModuleOutput = "CantinaClient"
public protocol ClientModuleOutput {
    var catalogRepository: CatalogRepository { get }
    var homeRepository: HomeRepository { get }
    var contactRepository: ContactRepository { get }
    var initialRepository: InitialRepository { get }
    var wineStatusRepository: WineStatusRepository { get }
}
