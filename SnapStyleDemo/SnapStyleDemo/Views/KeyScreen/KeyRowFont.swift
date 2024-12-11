//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

// TODO: Move to package?
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
