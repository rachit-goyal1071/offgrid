import SwiftUI

@propertyWrapper
struct Injected<T> {
    private let keyPath: KeyPath<DependencyContainer, () -> T>
    
    init(_ keyPath: KeyPath<DependencyContainer, () -> T>) {
        self.keyPath = keyPath
    }
    
    var wrappedValue: T {
        return DependencyContainer.shared[keyPath: keyPath]()
    }
}

extension EnvironmentValues {
    subscript<T>(keyPath: KeyPath<DependencyContainer, () -> T>) -> T {
        get {
            self[DynamicKey<T>.self] ?? DependencyContainer.shared[keyPath: keyPath]()
        }
        
        set {
            self[DynamicKey<T>.self] = newValue
        }
    }
    
}

private struct DynamicKey<T>: EnvironmentKey {
    static var defaultValue: T? { nil }
}
