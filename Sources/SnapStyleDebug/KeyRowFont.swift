//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

struct KeyRowFont: View {
    
    let keyPath: SnapStyle.FontKey.ValueKeyPath
    
    var body: some View {
        HStack {
            ForEach(SnapStyle.Item.Hierarchy.allCases, id: \.self) { hieararchy in
                Text("\(keyPath)")
//                    .style(font: key, hierarchy: hieararchy)

            }
        }
    }
}

#Preview {
    KeyRowFont(keyPath: \.content)
}
