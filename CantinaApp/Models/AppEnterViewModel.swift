import CantinaClient
import Combine
import Foundation

enum AppTabs {
    case home
    case catalog
    case contact
}

// sourcery: builder
protocol AppEnterViewModelInjection {
    // sourcery: module = client
    var catalogRepository: CatalogRepository { get }
    
    var homeViewModelInjection: HomeViewModelInjection { get }
    var catalogViewModelInjection: CatalogViewModelInjection { get }
    var contactsViewModelInjection: ContactsViewModelInjection { get }
}

final class AppEnterViewModel: ObservableObject {
    @Published var activeTab: AppTabs = .home
    
    private let injection: AppEnterViewModelInjection
    let homeViewModel: HomeViewModel
    let catalogViewModel: CatalogViewModel
    let contactsViewModel: ContactsViewModel
    
    init(injection: AppEnterViewModelInjection) {
        self.injection = injection
        self.homeViewModel = .init(injection: injection.homeViewModelInjection)
        self.catalogViewModel = .init(injection: injection.catalogViewModelInjection)
        self.contactsViewModel = .init(injection: injection.contactsViewModelInjection)
        
    }
}
