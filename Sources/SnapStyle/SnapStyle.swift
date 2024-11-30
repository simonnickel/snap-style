//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    internal var fonts: [FontKey : ValuesForContext<FontKey.Value>]
    
    public init() {
        fonts = DefaultValues.defaultFonts
    }
    
}
