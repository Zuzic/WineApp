import CantinaAssets
import SwiftUI

struct AppEnterView: View {
    @ObservedObject private var viewModel: AppEnterViewModel
    @State private var safeAreaInsets: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var body: some View {
        VStack {
            switch viewModel.appMode {
            case .appMode: appRootView
            case .initalMode: SplashView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.onAppear()
        }
        .background(
            GeometryReader { proxy in
                Color.clear.onAppear {
                    self.safeAreaInsets = proxy.safeAreaInsets
                }
            }
        )
        .environment(\.safeAreaEdgeInsets, safeAreaInsets)
    }
    
    init(viewModel: AppEnterViewModel) {
        self.viewModel = viewModel
    }
}

private extension AppEnterView {
    var appRootView: some View {
        TabView {
            home
            catalog
            contacts
        }
        .accentColor(Asset.Colors.accents.swiftUIColor)
        .applyTabbarStyle()
    }
    
    var catalog: some View {
        CatalogView(viewModel: viewModel.catalogViewModel)
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
extension AppTabs {
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
