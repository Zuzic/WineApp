// sourcery: ModuleDependecy = "CantinaClient"
public protocol ClientModuleDependency {
    var settings: ClientModuleSettings { get }
}

// sourcery: ModuleSettings = "CantinaClient"
public protocol ClientModuleSettings: AnyObject {
}
