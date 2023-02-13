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

private struct TransparentNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar(.visible, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarBackground(Color.clear, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func adoptNavigationBar() -> some View {
        self.modifier(NavigationBarModifier())
    }
    
    func transparentNavigationBar() -> some View {
        self.modifier(TransparentNavigationBarModifier())
    }
}
