//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {
    
    /// Container Type to hierarchically structure implementations of `StyleAttribute`.
    public enum Attribute {
        
        // Core Attributes
        case accent, icon, number, surface
        
        // Element Attributes
        case composition, font, padding, shape
        
    }
    
}
