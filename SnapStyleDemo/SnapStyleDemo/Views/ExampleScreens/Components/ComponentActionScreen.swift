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
                ElementStackView(axis: .horizontal)
            }
            .style(component: .action)
            
            StyleVStack(isStretching: false) {
                ElementStackView(axis: .horizontal, hierarchy: .secondary)
            }
            .style(component: .action)
            
            StyleVStack(spacing: \.spacingElements) {
                Text("Content")
                    .style(element: .title)
                ActionButtonsView()
            }
            .style(component: .content)
            
            StyleVStack(spacing: \.spacingElements) {
                Text("Card")
                    .style(element: .title)
                ActionButtonsView()
            }
            .style(component: .card)
            
        }
    }
}


// MARK: - Preview

#Preview {
    ComponentActionScreen()
}
