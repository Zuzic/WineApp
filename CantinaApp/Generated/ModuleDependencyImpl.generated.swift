// Generated using Sourcery 2.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import CantinaClient

// MARK: - ClientModuleDependency

final class ClientModuleDependencyImpl: CantinaClient.ClientModuleDependency {
    private let injector: Injector
    init(injector: Injector) {
        self.injector = injector
    }

    var settings: ClientModuleSettings { injector.settings }
} 

extension Injector {
    func build() -> ClientModuleDependency {
        ClientModuleDependencyImpl(injector: self)
    }
}
