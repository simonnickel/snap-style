//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyRowColor: View {
    
    let key: SnapStyle.ColorKey
    
    var body: some View {
        Text(key.description)
            .color(key)
    }
}

#Preview {
    KeyRowColor(key: .interactive)
}
