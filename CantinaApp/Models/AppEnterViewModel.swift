import CantinaClient
import Combine
import Foundation

enum AppTabs {
    case home
    case catalog
    case contact
    case shop
}

enum AppMode {
    case initalMode
    case appMode
}

// sourcery: builder
protocol AppEnterViewModelInjection {
    var initialRepository: InitialRepository { get }

    var homeViewModelInjection: HomeViewModelInjection { get }
    var catalogViewModelInjection: CatalogViewModelInjection { get }
    var contactsViewModelInjection: ContactsViewModelInjection { get }
    var shopViewModelInjection: ShopViewModelInjection { get }
}

final class AppEnterViewModel: ObservableObject {
    @Published var appMode: AppMode = .initalMode

    private let injection: AppEnterViewModelInjection
    let homeViewModel: HomeViewModel
    let catalogViewModel: CatalogViewModel
    let contactsViewModel: ContactsViewModel
    let shopViewModel: ShopViewModel

    init(injection: AppEnterViewModelInjection) {
        self.injection = injection
        self.homeViewModel = .init(injection: injection.homeViewModelInjection)
        self.catalogViewModel = .init(injection: injection.catalogViewModelInjection)
        self.contactsViewModel = .init(injection: injection.contactsViewModelInjection)
        self.shopViewModel = .init(injection: injection.shopViewModelInjection)
    }

    func onAppear() {
        Task {
            do {
                try await injection.initialRepository.loadInitialData()

                try await Task.sleep(for: .seconds(1))

                await MainActor.run {
                    appMode = .appMode
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
}
