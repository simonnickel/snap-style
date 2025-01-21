//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct ColorKey: StyleKey { public init() {} }
}

extension SnapStyle.ColorKey {
    
    
    // MARK: - ColorKey.Value
    
    public enum Value: StyleValue {
        
        public typealias WrappedValue = Color
        
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
