import Foundation

@propertyWrapper
public final class LazyAtomic<Value> {
    private let lock = NSLock()
    private var initialValue: Value!
    public var initializer: (() -> Value)?

    public init() {}

    public var wrappedValue: Value {
        get {
            lock.lock()
            defer { lock.unlock() }

            if let initializer = initializer {
                initialValue = initializer()
                self.initializer = nil
            }

            return initialValue
        }
        set {
            lock.lock()
            defer { lock.unlock() }

            initializer = nil
            initialValue = newValue
        }
    }
}
