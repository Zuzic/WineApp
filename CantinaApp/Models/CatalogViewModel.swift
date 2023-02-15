import CantinaClient
import Foundation

// sourcery: builder
protocol CatalogViewModelInjection {
    var catalogRepository: CatalogRepository { get }
}

final class CatalogViewModel: ObservableObject {
    @Published var catalog: [WineOutputModel] = []
    @Published var queryString: String = ""
    
    var brands: [String] = []
    
    private var rootCatalog: [WineOutputModel] = [] {
        didSet {
            catalog = rootCatalog
            
            brands = rootCatalog.reduce([], { partialResult, wine in
                guard !partialResult.contains(where: { $0 == wine.brand }) else { return partialResult }
                var items = partialResult
                items.append(wine.brand)
                return items
            })
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
                let result = await injection.catalogRepository.wines()
                
                await MainActor.run {
                    self.rootCatalog = result
                }
            }
        }
    }
    
    func onRefresh() {
        Task {
            do {
                let result = try await injection.catalogRepository.updateWines()
                
                await MainActor.run {
                    self.rootCatalog = result
                }
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
