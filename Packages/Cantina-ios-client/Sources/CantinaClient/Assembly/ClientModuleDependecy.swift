// sourcery: AutoMockable
// sourcery: ModuleDependecy = "CantinaClient"
public protocol ClientModuleDependency {
    var settings: ClientModuleSettings { get }
}

// sourcery: AutoMockable
// sourcery: ModuleSettings = "CantinaClient"
public protocol ClientModuleSettings: AnyObject {
    var isFirstLaunch: Bool { get set }
    var restEndpoint: String { get }
}
