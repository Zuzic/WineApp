// sourcery:inline:Injector.Settings.Imports
import CantinaClient

// sourcery:end
import CantinaAssets
import CantinaCommon
import Foundation
import CoreData

final class Settings {
    let dataContainerURL: URL = NSPersistentContainer.defaultDirectoryURL()

    @UserDefault(key: "isFirstLaunch", defaultValue: true)
    var isFirstLaunch: Bool

    @BundleInfo(key: "REST_URL", defaultValue: "zuzic.github.io/CantinaMock")
    var restEndpoint: String
}

// sourcery:inline:Injector.Settings
extension Settings: ClientModuleSettings {}
// sourcery:end
