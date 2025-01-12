//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct DebugKeyRowSurface: View {
    
    let keyPath: SnapStyle.SurfaceKey.ValueKeyPath
    
    var body: some View {
        Text("\(keyPath)")
            .style(surface: keyPath)
    }
}

#Preview {
    DebugKeyRowSurface(keyPath: \.interactive)
}
