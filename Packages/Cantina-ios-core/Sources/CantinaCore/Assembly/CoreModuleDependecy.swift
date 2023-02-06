// sourcery: ModuleDependecy = "CantinaCore"
public protocol CoreModuleDependency {
    var settings: CoreModuleSettings { get }
    var features: CoreModuleFeatures { get }
}

// sourcery: ModuleSettings = "CantinaCore"
public protocol CoreModuleSettings: AnyObject {
}

// sourcery: ModuleFeatures = "CantinaCore"
public protocol CoreModuleFeatures: AnyObject {
}
