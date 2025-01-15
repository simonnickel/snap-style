//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    public struct NumberKey: StyleKey { public init() {} }
}

extension SnapStyle.NumberKey {
    
    
    // MARK: - NumberKey.Value
    
    public enum Value: StyleValue {
        
        public typealias WrappedValue = Double
        
        case definition(WrappedValue)
        case reference(SnapStyle.NumberKey.ValueKeyPath)

        public var wrappedValue: WrappedValue {
            switch self {
                case .definition(let value): value
                case .reference:
                    fatalError("A `.reference` NumberKey should never be used to generate a value.")
            }
        }
        
        public var description: String {
            switch self {
                case .definition(let value): ".definition: \(value)"
                case .reference(let keyPath): ".reference: \(keyPath)"
            }
        }
    
    }
    
}
