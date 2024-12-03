//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public enum ColorKey: String, StyleKey {
        
        /// A key to indicate a missing value.
        case fallback
        
        case highlight
        
        case foreground
        case background
        case border
        
//        case backgroundContainer
//        case backgroundItemPrimary
//        case backgroundItemSecondary
//        case backgroundInteractivePrimary
//        case backgroundInteractiveSecondary
//        
//        case foregroundPrimary
//        case foregroundSecondary
//        case foregroundDisabled
        
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
