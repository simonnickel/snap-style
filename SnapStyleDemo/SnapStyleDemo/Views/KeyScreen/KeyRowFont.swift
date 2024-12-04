//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyRowFont: View {
    
    let key: SnapStyle.FontKey
    
    var body: some View {
        HStack {
            ForEach(SnapStyle.Item.Hierarchy.allCases, id: \.self) { hieararchy in
                Text(key.description)
                    .style(font: key, hierarchy: hieararchy)

            }
        }
    }
}

#Preview {
    KeyRowFont(key: .block)
}
