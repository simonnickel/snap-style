//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum FontKey: String, StyleKey {
        
        /// A key to indicate a missing value.
        case fallback

        // Item
        case title
        case content
        case label
        case value
        case cta
        case indicator
        
    }
    
}

extension SnapStyle.FontKey {
    
    public enum Value {
        case definition(Definition)
        case font(Font)
        case reference(SnapStyle.FontKey)
        
        var wrappedValue: Font {
            switch self {
                case .definition(let definition): Font.system(size: definition.size)
                case .font(let font): font
                case .reference(let key):
                    fatalError("A `.reference` FontValue should never be used to generate a value.")
            }
        }
    }
    
    public struct Definition {
        
        let size: CGFloat

        public init(size: CGFloat) {
            self.size = size
        }
        
    }
    
}
