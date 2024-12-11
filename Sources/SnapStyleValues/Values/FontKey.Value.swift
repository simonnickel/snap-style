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
        case erase

        public var wrappedValue: WrappedValue {
            switch self {
                case .definition(let definition): Font.system(size: definition.size)
                case .font(let font): font
                case .reference, .erase:
                    fatalError("A `.reference` FontValue should never be used to generate a value.")
            }
        }
        
        public var isErase: Bool {
            if case .erase = self { return true }
            return false
        }
        
    }
    
    public struct Definition {
        
        let size: CGFloat

        public init(size: CGFloat) {
            self.size = size
        }
        
    }
    
}
