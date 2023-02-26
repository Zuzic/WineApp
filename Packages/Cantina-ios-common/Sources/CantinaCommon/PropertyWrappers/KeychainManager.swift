import Foundation
import Security

@propertyWrapper
public final class KeychainManager<Value> where Value: Codable {
    enum KeychainError: Error {
        case invalidTag
        case unexpectedData
        case unhandledStatus(status: OSStatus)
        case unhandledError(error: Error)
    }

    let key: String
    let scope: String

    public var wrappedValue: Value? {
        didSet {
            let object = try? object(forKey: key)
            switch (wrappedValue, object) {
            case (let value, let object)
                where value != nil && object != nil: try? update(value!, forKey: key)
            case (let value, let object)
                where value != nil && object == nil: try? set(value!, forKey: key)
            default: try? delete(forKey: key)
            }
        }
    }

    public init(key: String, scope: String = "StreamsCore.KeychainManager", defaultValue: Value? = nil, wrappedValue _: Value? = nil) {
        self.key = key
        self.scope = scope
        self.wrappedValue = (try? object(forKey: key)) ?? defaultValue
    }

    private func set(_ value: Value, forKey defaultName: String) throws {
        do {
            let data = try JSONEncoder().encode(value)
            var addquery: [String: Any] = keychainQuery(tag: defaultName)
            addquery[kSecValueData as String] = data as AnyObject?
            let status = SecItemAdd(addquery as CFDictionary, nil)

            guard status == errSecSuccess else {
                throw KeychainError.unhandledStatus(status: status)
            }
        } catch {
            throw KeychainError.unhandledError(error: error)
        }
    }

    private func update(_ value: Value, forKey defaultName: String) throws {
        do {
            let data = try? JSONEncoder().encode(value)
            let query: [String: Any] = keychainQuery(tag: defaultName)
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = data as AnyObject?
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

            guard status == errSecSuccess else {
                throw KeychainError.unhandledStatus(status: status)
            }
        } catch {
            throw KeychainError.unhandledError(error: error)
        }
    }

    private func object(forKey defaultName: String) throws -> Value? {
        var getQuery: [String: AnyObject] = keychainQuery(tag: defaultName)
        getQuery[kSecReturnAttributes as String] = true as AnyObject
        getQuery[kSecReturnData as String] = true as AnyObject
        var queryResult: AnyObject?
        let status = SecItemCopyMatching(getQuery as CFDictionary, &queryResult)

        guard status == noErr else { throw KeychainError.unhandledStatus(status: status) }
        guard let existingItem = queryResult as? [String: AnyObject],
              let data = existingItem[kSecValueData as String] as? Data
        else { throw KeychainError.unexpectedData }
        return try? JSONDecoder().decode(Value.self, from: data)
    }

    private func delete(forKey defaultName: String) throws {
        let deletequery: [String: Any] = keychainQuery(tag: defaultName)
        let status = SecItemDelete(deletequery as CFDictionary)
        guard status == errSecSuccess else {
            throw KeychainError.unhandledStatus(status: status)
        }
    }

    private func keychainQuery(tag: String) -> [String: AnyObject] {
        let tag = "\(scope).\(tag)".data(using: .utf8)!

        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassKey
        query[kSecAttrApplicationTag as String] = tag as AnyObject?
        return query
    }
}
