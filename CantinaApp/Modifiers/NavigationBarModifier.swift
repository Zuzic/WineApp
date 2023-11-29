import CantinaAssets
import SwiftUI

private struct NavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar(.visible, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
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
        modifier(NavigationBarModifier())
    }

    func transparentNavigationBar() -> some View {
        modifier(TransparentNavigationBarModifier())
    }
}
