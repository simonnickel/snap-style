//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {
            
            StyleVStack {
                ElementStackView(axis: .horizontal)
            }
            .style(component: .card)
            
            StyleVStack {
                ElementStackView(axis: .horizontal, hierarchy: .secondary)
            }
            .style(component: .card)
            
        }
    }
}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
