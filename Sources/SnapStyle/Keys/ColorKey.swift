//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public enum ColorKey: String, StyleKey {
        
        /// A key to indicate a missing value.
        case fallback

        // Item
        case title
        case content
        case label
        case value
        case cta
        case indicator
        
        // Highlight
        case interactive
        case navigation
    }
    
}

extension SnapStyle.ColorKey {
    
    public enum Value {
        case color(Color)
        case reference(SnapStyle.ColorKey)
        
        var wrappedValue: Color {
            switch self {
                case .color(let color): color
                case .reference(let key):
                    fatalError("A `.reference` ColorValue should never be used to generate a value.")
            }
        }
    }
    
}
