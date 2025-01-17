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
        
        case value(WrappedValue)

        public var wrappedValue: WrappedValue {
            switch self {
                case .value(let value): value
            }
        }
        
        public var description: String {
            switch self {
                case .value(let value): ".value: \(value)"
            }
        }
    
    }
    
}
