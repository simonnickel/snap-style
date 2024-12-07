//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyRowSurface: View {
    
    let key: SnapStyle.SurfaceKey
    
    var body: some View {
        Text(key.description)
//            .style(surface: key)
    }
}

#Preview {
    KeyRowSurface(key: .interactive)
}
