import Combine
import Foundation

enum AppTabs {
    case home
    case catalog
    case contact
}

final class AppEnterViewModel: ObservableObject {
    @Published var activeTab: AppTabs = .home
}
