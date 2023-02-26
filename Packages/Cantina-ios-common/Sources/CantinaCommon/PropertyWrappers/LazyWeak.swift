import Foundation

@propertyWrapper
public final class LazyWeak<Value: AnyObject> {
    private let lock = NSLock()
    private weak var weakValue: Value?
    public var initializer: (() -> Value)!

    public init() {}

    public var wrappedValue: Value {
        lock.lock()
        defer { lock.unlock() }

        if let weakValue {
            return weakValue
        }

        let value = initializer()
        weakValue = value
        return value
    }
}
