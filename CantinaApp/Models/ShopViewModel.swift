import CantinaClient
import Foundation

// sourcery: builder
protocol ShopViewModelInjection {
    var shopRepository: ShopRepository { get }

    var shopFilterViewModelInjection: ShopFilterViewModelInjection { get }
}

final class ShopViewModel: ObservableObject {
    @Published private(set) var filters: [ShopFilterModel] = []

    @Published private(set) var shopFilterViewModel: ShopFilterViewModel!
    private let injection: ShopViewModelInjection

    init(injection: ShopViewModelInjection) {
        self.injection = injection
        self.shopFilterViewModel = .init(injection: injection.shopFilterViewModelInjection,
                                         delegate: self)
    }

    func onAppear() {
        Task {
            do {
                let result = try await injection.shopRepository.loadShopAddresses()

                await MainActor.run {
                    self.filters = result.shopFilters()
                    self.shopFilterViewModel.update(countries: result)
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }

    func onSelect(city: CityOutputModel) {
        shopFilterViewModel.select(city: city)
    }

    func onRefresh() {}
}

extension ShopViewModel: ShopFilterViewModelDelegate {
    func didSelect(filter: ShopFilterModel) {
        filters = [filter]
    }

    func didReset(filters: [ShopFilterModel]) {
        self.filters = filters
    }
}
