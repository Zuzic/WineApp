import CantinaClient
import Foundation

// sourcery: builder
protocol CatalogViewModelInjection {
    // sourcery: module = client
    var catalogRepository: CatalogRepository { get }
}

final class CatalogViewModel: ObservableObject {
    private let injection: CatalogViewModelInjection
    
    init(injection: CatalogViewModelInjection) {
        self.injection = injection
    }
    
    func onAppear() {
        Task {
            do {
                let result = try await injection.catalogRepository.wines()
                
                await MainActor.run {
                    debugPrint("count \(result.count)")
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
}
