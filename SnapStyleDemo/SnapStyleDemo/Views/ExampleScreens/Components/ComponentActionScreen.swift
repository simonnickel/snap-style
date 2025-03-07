//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentActionScreen: View {
    var body: some View {
        StyleScreen {
            
            StyleVStack(isStretching: false) {
                ElementStack(axis: .horizontal)
            }
            .style(component: .action)
            
            StyleVStack(isStretching: false) {
                ElementStack(axis: .horizontal, hierarchy: .secondary)
            }
            .style(component: .action)
            
        }
    }
}


// MARK: - Preview

#Preview {
    ComponentActionScreen()
}
