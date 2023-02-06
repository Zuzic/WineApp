import Foundation

// _sourcery:inline:CoreModule.UnwrapModuleDependencyImports
// _sourcery:end

// sourcery: Module = "CantinaCore"
final public class CoreModule: CoreModuleOutput {
    private let injection: CoreModuleDependency

    public init(injection: CoreModuleDependency) {
        self.injection = injection
    }
}

// _sourcery:inline:CoreModule.UnwrapModuleDependency
// _sourcery:end
