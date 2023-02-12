import CantinaAssets
import SwiftUI

private struct NavigationBarModifier: ViewModifier {
    @Environment(\.isNavigationVisible) var isNavigationVisible
    
    func body(content: Content) -> some View {
        content
            .toolbar(isNavigationVisible ? .visible : .hidden, for: .navigationBar)
            .toolbarBackground(isNavigationVisible ? .visible : .hidden, for: .navigationBar)
            .toolbarBackground(Asset.Colors.surface.swiftUIColor, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func adoptNavigationBar() -> some View {
        self.modifier(NavigationBarModifier())
    }
}
