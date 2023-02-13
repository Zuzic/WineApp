import CantinaClient
import Foundation

// sourcery: builder
protocol CatalogViewModelInjection {
    // sourcery: module = client
    var catalogRepository: CatalogRepository { get }
}

final class CatalogViewModel: ObservableObject {
    @Published var catalog: [WineOutputModel] = []
    @Published var queryString: String = ""
    
    private var rootCatalog: [WineOutputModel] = [] {
        didSet {
            catalog = rootCatalog
        }
    }
    
    private let injection: CatalogViewModelInjection
    
    init(injection: CatalogViewModelInjection) {
        self.injection = injection
        self.applySearchSubscription()
    }
    
    func onAppear() {
        Task {
            do {
                let result = try await injection.catalogRepository.wines()
                
                await MainActor.run {
                    self.rootCatalog = result
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
}

private extension CatalogViewModel {
    func applySearchSubscription() {
        $queryString
            .receive(on: DispatchQueue.main)
            .map {[weak self] value in
                guard let self else { return [] }
                guard !value.isEmpty else { return self.rootCatalog } 
                return self.rootCatalog.filter { $0.name.lowercased().contains(value.lowercased()) }
            }.assign(to: &$catalog)
    }
}
