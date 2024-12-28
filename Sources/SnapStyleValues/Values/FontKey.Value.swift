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
        
        case definition(Definition)
        case font(Font)
        case reference(SnapStyle.FontKey.ValueKeyPath)

        public var wrappedValue: WrappedValue {
            switch self {
                case .definition(let definition): Font.system(size: definition.size)
                case .font(let font): font
                case .reference:
                    fatalError("A `.reference` FontValue should never be used to generate a value.")
            }
        }
        
        public var description: String {
            switch self {
                case .definition(let definition): ".definition: \(definition)"
                case .font(let font): ".font"
                case .reference(let keyPath): ".reference: \(keyPath)"
            }
        }
        
        
        // MARK: - Definition
        
        public struct Definition: CustomStringConvertible {
            
            let size: CGFloat
            
            public init(size: CGFloat) {
                self.size = size
            }
            
            public var description: String { "size: \(size)" }
            
        }
    
    }
    
}
