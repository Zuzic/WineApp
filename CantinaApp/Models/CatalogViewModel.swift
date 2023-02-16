import CantinaClient
import Foundation

// sourcery: builder
protocol CatalogViewModelInjection {
    var catalogRepository: CatalogRepository { get }
}

final class CatalogViewModel: ObservableObject {
    @Published var catalog: [WineOutputModel] = []
    @Published var searchQuery: String = ""
    @Published var filterQuery: WineFilterOutputModel
    private(set) var filter: WineFilterOutputModel?
    
    private var rootCatalog: [WineOutputModel] = [] {
        didSet {
            catalog = rootCatalog
        }
    }
    
    private let injection: CatalogViewModelInjection
    
    init(injection: CatalogViewModelInjection) {
        self.injection = injection
        self.filterQuery = .init(sections: [.type([]), .brand([]), .grape([])])
        self.applySearchSubscription()
    }
    
    func onAppear() {
        Task {
            do {
                let result = await injection.catalogRepository.wines()
                let filter = await injection.catalogRepository.filter()
                
                await MainActor.run {
                    self.rootCatalog = result
                    self.filter = filter
                }
            }
        }
    }
    
    func onRefresh() {
        Task {
            do {
                let result = try await injection.catalogRepository.updateWines()
                let filter = await injection.catalogRepository.filter()
                
                await MainActor.run {
                    self.rootCatalog = result
                    self.filter = filter
                }
            }
        }
    }
    
    func filterByBrand(item: WineFilterItemOutputModel) {
        let items: [WineFilterSectionOutputModel] = filterQuery.sections.reduce([]) { partialResult, section in
            var result = partialResult
            
            switch section {
            case .grape(let items): result.append(.grape(items))
            case .type(let items): result.append(.type(items))
            case .brand(let items):
                var itemsResult = items
                if let index = items.firstIndex(where: { $0.title.lowercased() == item.title.lowercased() }) {
                    itemsResult.remove(at: index)
                } else {
                    itemsResult.append(item)
                }
                result.append(.brand(itemsResult))
            }
            return result
        }
        
        filterQuery = .init(sections: items)
    }
    
    func filterByType(item: WineFilterItemOutputModel) {
        let items: [WineFilterSectionOutputModel] = filterQuery.sections.reduce([]) { partialResult, section in
            var result = partialResult
            
            switch section {
            case .grape(let items): result.append(.grape(items))
            case .brand(let items): result.append(.brand(items))
            case .type(let items):
                var itemsResult = items
                if let index = items.firstIndex(where: { $0.title.lowercased() == item.title.lowercased() }) {
                    itemsResult.remove(at: index)
                } else {
                    itemsResult.append(item)
                }
                result.append(.type(itemsResult))
            }
            return result
        }
        
        filterQuery = .init(sections: items)
    }
    
    func filterByGrape(item: WineFilterItemOutputModel) {
        let items: [WineFilterSectionOutputModel] = filterQuery.sections.reduce([]) { partialResult, section in
            var result = partialResult
            
            switch section {
            case .type(let items): result.append(.type(items))
            case .brand(let items): result.append(.brand(items))
            case .grape(let items):
                var itemsResult = items
                if let index = items.firstIndex(where: { $0.title.lowercased() == item.title.lowercased() }) {
                    itemsResult.remove(at: index)
                } else {
                    itemsResult.append(item)
                }
                result.append(.grape(itemsResult))
            }
            return result
        }
        
        filterQuery = .init(sections: items)
    }
}

private extension CatalogViewModel {
    func applySearchSubscription() {
        $searchQuery
            .receive(on: DispatchQueue.main)
            .map { [weak self] value in
                guard let self else { return [] }
                guard !value.isEmpty else { return self.rootCatalog }
                return self.rootCatalog.filter { $0.name.lowercased().contains(value.lowercased()) }
            }.assign(to: &$catalog)
        
        $filterQuery
            .receive(on: DispatchQueue.main)
            .map { [weak self] value in
                guard let self else { return [] }
                
                let filterItemsTotal: [WineFilterItemOutputModel] = value.sections.reduce([], { partialResult, section in
                    var result = partialResult
                    switch section {
                    case .type(let items): result.append(contentsOf: items)
                    case .brand(let items): result.append(contentsOf: items)
                    case .grape(let items): result.append(contentsOf: items)
                    }
                    
                    return result
                })
                
                let sectionItemsTotal: Int = value.sections.reduce(0, { partialResult, section in
                    var result = partialResult
                    switch section {
                    case .type(let items): result += items.count > 0 ? 1 : 0
                    case .brand(let items): result += items.count > 0 ? 1 : 0
                    case .grape(let items): result += items.count > 0 ? 1 : 0
                    }
                    
                    return result
                })
                
                guard filterItemsTotal.count > 0 else { return self.rootCatalog }
                
                let result: [WineOutputModel] = self.rootCatalog.reduce([]) { partialResult, wine in
                    var result = partialResult
                    
                    let filter = value.sections.filter({ section in
                        switch section {
                        case .grape(let items):
                            return items.contains(where: { $0.title.lowercased() == wine.grape.lowercased() })
                        case .type(let items):
                            return items.contains(where: { $0.title.lowercased() == wine.type.lowercased() })
                        case .brand(let items):
                            return items.contains(where: { $0.title.lowercased() == wine.brand.lowercased() })
                        }
                    })
                    
                    if filter.count >= sectionItemsTotal  {
                        result.append(wine)
                    }
                    
                    return result
                }
                
                return result
            }.assign(to: &$catalog)
    }
}
