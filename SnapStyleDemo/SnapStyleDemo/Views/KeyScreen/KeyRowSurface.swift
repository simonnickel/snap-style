//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyRowSurface: View {
    
    let keyPath: SnapStyle.SurfaceKey.ValueKeyPath
    
    var body: some View {
        Text(keyPath.debugDescription)
//            .style(surface: key)
    }
}

#Preview {
    KeyRowSurface(keyPath: \.interactive)
}
