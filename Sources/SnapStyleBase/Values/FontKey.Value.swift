//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct FontKey: StyleKey { public init() {} }
}

extension SnapStyle.FontKey {
    
    
    // MARK: - FontKey.Value
    
    public enum Value: StyleValue {
        
        public typealias WrappedValue = Font
        public typealias Adjustment = SnapStyle.FontKey.Adjustment

        case with(size: CGFloat, weight: Font.Weight = .regular)
        case font(Font)

        public var wrappedValue: WrappedValue {
            switch self {
                case .with(size: let size, let weight): Definition(size: size, weight: weight).font
                case .font(let font): font
            }
        }
        
        public var description: String {
            switch self {
                case .with(size: let size, weight: let weight): ".definition: \(Definition(size: size, weight: weight))"
                case .font(let font): ".font"
            }
        }
        
        
        // MARK: Definition
        
        public struct Definition: CustomStringConvertible {
            
            let size: CGFloat
            let weight: Font.Weight
            
            public init(size: CGFloat, weight: Font.Weight) {
                self.size = size
                self.weight = weight
            }
            
            var font: Font {
                Font.system(size: size, weight: weight)
            }
            
            public var description: String { "size: \(size), weight: \(weight)" }
            
        }
    
    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.FontKey.Value
        
        public func applied(on value: Value) -> Value {
            value
        }

    }

}
