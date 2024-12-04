//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    internal var fonts: [FontKey : ValueBuilder<FontKey.Value>]
    internal var surfaces: [SurfaceKey : ValueBuilder<SurfaceKey.Value>]

    public init() {
        fonts = FontValues.defaultValues
        surfaces = SurfaceValues.defaultValues
    }
    
}
