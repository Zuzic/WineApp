import CantinaAssets
import SwiftUI

struct AppEnterView: View {
    @ObservedObject private var viewModel: AppEnterViewModel
    @State private var isNavigationVisible: Bool = false
    
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
    }
    
    init(viewModel: AppEnterViewModel) {
        self.viewModel = viewModel
    }
}

private extension AppEnterView {
    var appRootView: some View {
        NavigationStack {
            TabView(selection: $viewModel.activeTab) {
                ForEach(viewModel.tabs) { item in
                    switch item {
                    case .home: home
                    case .catalog: catalog
                    case .contact: contacts
                    }
                }
                
            }
            .accentColor(Asset.Colors.accents.swiftUIColor)
        }
        .environment(\.isNavigationVisible, isNavigationVisible)
        .onChange(of: viewModel.activeTab) { activeTab in
            isNavigationVisible = activeTab == .catalog
        }
    }
    
    var catalog: some View {
        CatalogView(viewModel: viewModel.catalogViewModel)
            .tabItem {
                VStack {
                    AppTabs.catalog.title
                    AppTabs.catalog.icon
                }
            }
            .tag(AppTabs.catalog)
            .applyTabbarStyle()
            .adoptNavigationBar()
    }
    
    var home: some View {
        HomeView(viewModel: viewModel.homeViewModel)
            .tabItem {
                VStack {
                    AppTabs.home.title
                    AppTabs.home.icon
                }
            }
            .tag(AppTabs.home)
            .applyTabbarStyle()
            .adoptNavigationBar()
    }
    
    var contacts: some View {
        ContactsView(viewModel: viewModel.contactsViewModel)
            .tabItem {
                VStack {
                    AppTabs.contact.title
                    AppTabs.contact.icon
                }
            }
            .tag(AppTabs.contact)
            .applyTabbarStyle()
            .adoptNavigationBar()
    }
}

// MARK: -
extension AppTabs: Identifiable {
    var id: Int {
        switch self {
        case .home: return 101
        case .catalog: return 102
        case .contact: return 103
        }
    }
    
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
