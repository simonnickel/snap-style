//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    internal var fonts: [FontKey : ValueBuilder<FontKey.Value>]
    internal var colors: [ColorKey : ValueBuilder<ColorKey.Value>]
    
    public init() {
        fonts = FontValues.defaultValues
        colors = ColorValues.defaultValues
    }
    
}
