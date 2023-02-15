import Foundation

// sourcery: builder
protocol StorageInjection {}

final class Storage {
    private let injection: StorageInjection
    private(set) var data: DataResponse?
    
    init(injection: StorageInjection) {
        self.injection = injection
    }
    
    func update(data: DataResponse) {
        self.data = data
    }
}
