import CantinaAssets
import SwiftUI

private struct TabbarStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Asset.Colors.surface.swiftUIColor, for: .tabBar)
    }
}

extension View {
    func applyTabbarStyle() -> some View {
        self.modifier(TabbarStyleModifier())
    }
}
