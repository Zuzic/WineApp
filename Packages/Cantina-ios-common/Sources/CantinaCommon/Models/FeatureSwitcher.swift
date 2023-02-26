public final class FeatureSwitcher {
    public enum State: Equatable, Hashable {
        case on
        case off
        case config(Bool)

        var isEnabled: Bool {
            switch self {
            case .on: return true
            case .off: return false
            case .config(let isOn): return isOn
            }
        }
    }

    public let storedValue: UserDefault<Bool?>
    public let name: String
    public let flag: FeatureFlag?
    public let defaultValue: Bool

    public var enabled: Bool { state.isEnabled }
    public var state: State {
        get {
            if let storedValue = storedValue.wrappedValue {
                return storedValue ? .on : .off
            } else {
                return .config(flag?.enabled ?? defaultValue)
            }
        }

        set {
            switch newValue {
            case .on: storedValue.wrappedValue = true
            case .off: storedValue.wrappedValue = false
            case .config: storedValue.wrappedValue = nil
            }
        }
    }

    public init(name: String, flag: FeatureFlag?, defaultValue: Bool) {
        self.name = name
        self.flag = flag
        self.defaultValue = defaultValue
        self.storedValue = UserDefault<Bool?>(key: "featureSwitcher.\(name)", defaultValue: nil)
    }
}
