import Foundation

struct LoginRequestModel: Encodable {
    let username: String
    let password: String

    init(username: String, password: String) {
        self.password = password
        self.username = username
    }

    enum CodingKeys: String, CodingKey {
        case username
        case password
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(password, forKey: .password)
    }
}
