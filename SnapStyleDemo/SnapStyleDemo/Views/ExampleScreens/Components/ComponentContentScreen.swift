//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentContentScreen: View {
    var body: some View {
        StyleScreen {
            
            StyleVStack {
                ElementStackView(axis: .horizontal)
            }
            .style(component: .content)
            
            StyleVStack {
                ElementStackView(axis: .horizontal, hierarchy: .secondary)
            }
            .style(component: .content)
            
        }
    }
}


// MARK: - Preview

#Preview {
    ComponentContentScreen()
}
