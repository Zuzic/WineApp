@testable import CantinaClient
import Foundation
import XCTest

final class InitialRepositoryTests: XCTestCase {
    private func initedModule() async throws -> ClientModule {
        let settings = ClientModuleSettingsMock()
        settings.restEndpoint = "zuzic.github.io/CantinaMock"
        settings.isFirstLaunch = false
        
        let moduleInjection = ClientModuleDependencyMock()
        moduleInjection.settings = settings
        
        let module = ClientModule(injection: moduleInjection)
        return module
    }
    
    func testInitialData() async throws {
        let module = try await initedModule()
        
        try await module.initialRepository.loadInitialData()
        let data = module.storage.data
        
        XCTAssertNotNil(data)
    }
}
