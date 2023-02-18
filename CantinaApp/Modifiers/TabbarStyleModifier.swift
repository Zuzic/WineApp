import CantinaAssets
import SwiftUI

private struct TabbarStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarBackground(Asset.Colors.surface.swiftUIColor, for: .tabBar)
    }
}

extension View {
    func applyTabbarStyle() -> some View {
        self.modifier(TabbarStyleModifier())
    }
}
