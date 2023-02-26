import Foundation

// sourcery: AutoMockable
public protocol CatalogRepository {
    func wines() async -> [WineOutputModel]
    func updateWines() async throws -> [WineOutputModel]
    func filter() async -> WineFilterOutputModel
}

// sourcery: builder
protocol CatalogRepositoryInjection {
    var restClient: RestApiClient { get }
    var storage: Storage { get }
    var initialRepository: InitialRepository { get }
}

final class CatalogRepositoryImpl: CatalogRepository {
    private let injection: CatalogRepositoryInjection

    init(injection: CatalogRepositoryInjection) {
        self.injection = injection
    }
    
    func wines() async -> [WineOutputModel] {
        injection.storage.data?.catalog ?? []
    }
    
    func updateWines() async throws -> [WineOutputModel] {
        try await injection.initialRepository.loadInitialData()
        return await wines()
    }
    
    func filter() async -> WineFilterOutputModel {
        let catalog = await wines()
        let typeSectionItems: [WineFilterItemOutputModel] = catalog.reduce([]) { partialResult, wine in
            guard !partialResult.contains(where: { $0.title == wine.type }) else { return partialResult }
            var items = partialResult
            items.append(WineFilterItemOutputModel(title: wine.type))
            return items
        }
        
        let brandSectionItems: [WineFilterItemOutputModel] = catalog.reduce([]) { partialResult, wine in
            guard !partialResult.contains(where: { $0.title == wine.brand }) else { return partialResult }
            var items = partialResult
            items.append(WineFilterItemOutputModel(title: wine.brand))
            return items
        }
        
        let grapeSectionItems: [WineFilterItemOutputModel] = catalog.reduce([]) { partialResult, wine in
            guard !partialResult.contains(where: { $0.title == wine.grape }) else { return partialResult }
            var items = partialResult
            items.append(WineFilterItemOutputModel(title: wine.grape))
            return items
        }
        
        return .init(sections: [.type(typeSectionItems),
                                .brand(brandSectionItems),
                                .grape(grapeSectionItems)])
    }
}
