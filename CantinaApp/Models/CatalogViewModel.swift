import CantinaClient
import Foundation

// sourcery: builder
protocol CatalogViewModelInjection {
    var catalogRepository: CatalogRepository { get }
    
    var wineDetailsViewModelInjection: WineDetailsViewModelInjection { get }
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
    
    var allFilterItems: [WineFilterItemOutputModel]  {
        filterQuery.sections.reduce([], { partialResult, section in
            var result = partialResult
            switch section {
            case .type(let items): result.append(contentsOf: items)
            case .brand(let items): result.append(contentsOf: items)
            case .grape(let items): result.append(contentsOf: items)
            }
            return result
        })
    }
    
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
    
    func filter(item: WineFilterItemOutputModel, type: WineFilterSectionOutputModel) {
        let items: [WineFilterSectionOutputModel] = filterQuery.sections.reduce([]) { partialResult, section in
            var result = partialResult
            
            func updatedSection(at items: [WineFilterItemOutputModel], by item: WineFilterItemOutputModel) -> [WineFilterItemOutputModel] {
                var itemsResult = items
                if let index = items.firstIndex(where: { $0.title.lowercased() == item.title.lowercased() }) {
                    itemsResult.remove(at: index)
                } else {
                    itemsResult.append(item)
                }
                return itemsResult
            }
            
            switch section {
            case .grape(let items):
                if case .grape = type {
                    result.append(.grape(updatedSection(at: items, by: item)))
                } else {
                    result.append(.grape(items))
                }
            case .type(let items):
                if case .type = type {
                    result.append(.type(updatedSection(at: items, by: item)))
                } else {
                    result.append(.type(items))
                }
            case .brand(let items):
                if case .brand = type {
                    result.append(.brand(updatedSection(at: items, by: item)))
                } else {
                    result.append(.brand(items))
                }
            }
            return result
        }
        filterQuery = .init(sections: items)
    }
    
    func resetFilter() {
        filterQuery = .init(sections: [.type([]), .brand([]), .grape([])])
    }
    
    func preparedWineDetailsViewModel(at wine: WineOutputModel) -> WineDetailsViewModel {
        return .init(injection: injection.wineDetailsViewModelInjection, wine: wine)
    }
}

private extension CatalogViewModel {
    func applySearchSubscription() {
        $searchQuery
            .receive(on: DispatchQueue.main)
            .map { [weak self] _ in
                guard let self else { return [] }
                let items = self.filteredItems(for: self.filterQuery)
                return self.searchedItems(for: self.searchQuery, items: items)
            }.assign(to: &$catalog)
        
        $filterQuery
            .receive(on: DispatchQueue.main)
            .map { [weak self] value in
                guard let self else { return [] }
                let items = self.filteredItems(for: value)
                return self.searchedItems(for: self.searchQuery, items: items)
            }.assign(to: &$catalog)
    }
    
    func filteredItems(for filterQuery: WineFilterOutputModel) -> [WineOutputModel] {
        let sectionItemsTotal: Int = filterQuery.sections.reduce(0, { partialResult, section in
            var result = partialResult
            switch section {
            case .type(let items): result += items.count > 0 ? 1 : 0
            case .brand(let items): result += items.count > 0 ? 1 : 0
            case .grape(let items): result += items.count > 0 ? 1 : 0
            }
            
            return result
        })
        
        guard self.allFilterItems.count > 0 else { return self.rootCatalog }
        
        let result: [WineOutputModel] = self.rootCatalog.reduce([]) { partialResult, wine in
            var result = partialResult
            
            let filter = filterQuery.sections.filter({ section in
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
    }
    
    func searchedItems(for query: String, items: [WineOutputModel]) -> [WineOutputModel] {
        guard !query.isEmpty else { return items }
        guard !query.isEmpty else { return items }
        return items.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}
