import SwiftUI

struct SafeAreaKey: EnvironmentKey {
    static var defaultValue: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
}

extension EnvironmentValues {
    var  safeAreaEdgeInsets: EdgeInsets {
        get { self[SafeAreaKey.self] }
        set { self[SafeAreaKey.self] = newValue }
    }
}
