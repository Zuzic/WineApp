import Foundation

@propertyWrapper
public struct BundleInfo<Value> {
    private let key: String
    private let bundle: Bundle
    private let defaultValue: () -> Value

    public init(key: String, bundle: Bundle = .main, defaultValue: @escaping @autoclosure () -> Value) {
        self.key = key
        self.bundle = bundle
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value {
        return bundle.object(forInfoDictionaryKey: key) as? Value ?? defaultValue()
    }
}
