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
        public typealias Adjustment = SnapStyle.NumberKey.Adjustment

        case value(WrappedValue)

        public func create(with: WrappedValue) -> Self {
            .value(wrappedValue)
        }
        
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


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.NumberKey.Value

        public func applied(on value: Value.WrappedValue) -> Value.WrappedValue {
            value
        }
    }

}
