import SwiftUI

struct NavigationVisibilityKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var isNavigationVisible: Bool {
        get { self[NavigationVisibilityKey.self] }
        set { self[NavigationVisibilityKey.self] = newValue }
    }
}
