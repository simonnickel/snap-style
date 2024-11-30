//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyRowFont: View {
    
    let key: SnapStyle.FontKey
    
    var body: some View {
        Text(key.description)
            .font(key)
    }
}

#Preview {
    KeyRowFont(key: .block)
}
