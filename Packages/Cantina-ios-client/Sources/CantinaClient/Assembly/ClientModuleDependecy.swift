// sourcery: ModuleDependecy = "CantinaClient"
public protocol ClientModuleDependency {
    var settings: ClientModuleSettings { get }
}

// sourcery: ModuleSettings = "CantinaClient"
public protocol ClientModuleSettings: AnyObject {
    var isFirstLaunch: Bool { get set }
    var restEndpoint: String { get }
}
