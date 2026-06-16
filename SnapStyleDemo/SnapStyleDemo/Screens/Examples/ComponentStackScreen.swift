//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentStackScreen: View {

    var body: some View {
        StyleScreen {

            containerStack(component: .contentCard)
            containerStack(component: .accentCard)
            containerStack(component: .infoCard)
            containerStack(component: .metricCard)
            
        }
    }
    
    @ViewBuilder
    private func containerStack(component: Style.Component) -> some View {
        StyleStack(spacing: \.spacingElements) {
            Text("Stack of .\(component.description)")
                .style(element: .title)
            StyleStack(spacing: \.spacingElements) {
                Text("Level 2")
                    .style(element: .title)
                StyleStack(spacing: \.spacingElements) {
                    Text("Level 3")
                        .style(element: .title)
                }
                .styleContainer()
            }
            .styleContainer()
        }
        .styleContainer()
        .style(component: component, applyContainer: false)
    }

}


// MARK: - Preview

#Preview {
    ComponentStackScreen()
}
