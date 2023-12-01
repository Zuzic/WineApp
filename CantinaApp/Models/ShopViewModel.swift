import CantinaClient
import Foundation

// sourcery: builder
protocol ShopViewModelInjection {
    var shopRepository: ShopRepository { get }
}

final class ShopViewModel: ObservableObject {
    @Published var addresses: [CountryOutputModel] = []

    private let injection: ShopViewModelInjection

    init(injection: ShopViewModelInjection) {
        self.injection = injection
    }

    func onAppear() {
        Task {
            do {
                let result = try await injection.shopRepository.loadShopAddresses()

                await MainActor.run {
                    self.addresses = result
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }

    func onRefresh() {}
}
