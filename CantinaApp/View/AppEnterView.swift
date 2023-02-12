import CantinaAssets
import SwiftUI

struct AppEnterView: View {
    @ObservedObject private var viewModel: AppEnterViewModel
    
    var body: some View {
        TabView {
            home
            catalog
            contacts
        }
        .accentColor(Asset.Colors.accents.swiftUIColor)
    }
    
    init(viewModel: AppEnterViewModel) {
        self.viewModel = viewModel
    }
}

private extension AppEnterView {
    var catalog: some View {
        CatalogView()
            .tabItem {
                VStack {
                    AppTabs.catalog.title
                    AppTabs.catalog.icon
                }
            }
    }
    
    var home: some View {
        HomeView(viewModel: viewModel.homeViewModel)
            .tabItem {
                VStack {
                    AppTabs.home.title
                    AppTabs.home.icon
                }
            }
            .ignoresSafeArea()
    }
    
    var contacts: some View {
        ContactsView(viewModel: viewModel.contactsViewModel)
            .tabItem {
                VStack {
                    AppTabs.contact.title
                    AppTabs.contact.icon
                }
            }
    }
}

// MARK: -
private extension AppTabs {
    var title: some View {
        switch self {
        case .home: return Text(L10n.Tab.home)
        case .catalog: return Text(L10n.Tab.catalog)
        case .contact: return Text(L10n.Tab.contacts)
        }
    }
    
    var icon: some View {
        switch self {
        case .home: return Asset.Icons.Tabbar.myWines.swiftUIImage
        case .catalog: return Asset.Icons.Tabbar.catalog.swiftUIImage
        case .contact: return Asset.Icons.Tabbar.contatcs.swiftUIImage
        }
    }
}
