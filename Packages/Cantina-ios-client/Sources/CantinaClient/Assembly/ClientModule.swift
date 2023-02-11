import Foundation

// _sourcery:inline:ClientModule.UnwrapModuleDependencyImports
// _sourcery:end

// sourcery: Module = "CantinaClient"
final public class ClientModule: ClientModuleOutput {
    private let injection: ClientModuleDependency

    public init(injection: ClientModuleDependency) {
        self.injection = injection
    }
}

// _sourcery:inline:ClientModule.UnwrapModuleDependency
// swiftlint: disable: identifier_name
extension ClientModule {
    var clientModuleDependencySettings: ClientModuleSettings { injection.settings }
}
// _sourcery:end
