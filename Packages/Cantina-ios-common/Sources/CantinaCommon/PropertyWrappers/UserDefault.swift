import Foundation

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

@propertyWrapper
public class UserDefault<Value> {
    private let key: String
    private let container: UserDefaults
    private let defaultValue: () -> Value

    public init(key: String, container: UserDefaults = .standard, defaultValue: @escaping @autoclosure () -> Value) {
        self.key = key
        self.container = container
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue()
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
            container.synchronize()
        }
    }
}
