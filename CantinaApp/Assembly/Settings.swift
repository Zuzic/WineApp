import CoreData
import Foundation
// sourcery:inline:Injector.Settings.Imports

// sourcery:end
import CantinaAssets
import StreamsCommon

final class Settings {
    let dataContainerURL: URL = NSPersistentContainer.defaultDirectoryURL()
    
    @UserDefault(key: "isFirstLaunch", defaultValue: true)
    var isFirstLaunch: Bool
}

// sourcery:inline:Injector.Settings
// sourcery:end
