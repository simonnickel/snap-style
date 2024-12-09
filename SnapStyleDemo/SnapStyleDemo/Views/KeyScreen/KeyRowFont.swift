//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyRowFont: View {
    
    let keyPath: SnapStyle.FontKey.ValueKeyPath
    
    var body: some View {
        HStack {
            ForEach(SnapStyle.Item.Hierarchy.allCases, id: \.self) { hieararchy in
                Text(keyPath.debugDescription)
//                    .style(font: key, hierarchy: hieararchy)

            }
        }
    }
}

#Preview {
    KeyRowFont(keyPath: \.content)
}
