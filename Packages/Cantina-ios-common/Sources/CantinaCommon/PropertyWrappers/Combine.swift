import Combine
import Foundation

@propertyWrapper
public struct CombinePipe<Value> {
    private let receiveOnQueue: DispatchQueue?

    public init(receiveOn queue: DispatchQueue? = .main) {
        self.receiveOnQueue = queue
        self.projectedValue = PassthroughSubject<Value, Never>()
    }

    public var wrappedValue: AnyPublisher<Value, Never> {
        if let queue = receiveOnQueue {
            return projectedValue.receive(on: queue).eraseToAnyPublisher()
        } else {
            return projectedValue.eraseToAnyPublisher()
        }
    }

    public let projectedValue: PassthroughSubject<Value, Never>

    public func send(_ input: Value) {
        projectedValue.send(input)
    }
}

@propertyWrapper
public struct CombineState<Value> {
    private let receiveOnQueue: DispatchQueue?

    public init(value: Value, receiveOn queue: DispatchQueue? = .main) {
        self.receiveOnQueue = queue
        self.projectedValue = CurrentValueSubject<Value, Never>(value)
    }

    public var wrappedValue: AnyPublisher<Value, Never> {
        if let queue = receiveOnQueue {
            return projectedValue.receive(on: queue).eraseToAnyPublisher()
        } else {
            return projectedValue.eraseToAnyPublisher()
        }
    }

    public let projectedValue: CurrentValueSubject<Value, Never>

    public func send(_ input: Value) {
        projectedValue.send(input)
    }
}
