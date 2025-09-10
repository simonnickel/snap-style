//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentStackScreen: View {

    var body: some View {
        StyleScreen {

            content(component: [.contentCard, .contentCard, .contentCard])
            content(component: [.accentCard, .accentCard, .accentCard])
            content(component: [.accentCard, .contentCard, .accentCard])
            content(component: [.accentCard, .contentCard, .contentCard])

        }
    }

    @ViewBuilder
    private func content(component: [Style.ComponentDefinition]) -> some View {
        StyleStack(spacing: \.spacingElements) {

            Text(component.description)
                .style(element: .title)

            StyleStack(spacing: \.spacingElements) {

                Text("Level 1")
                    .style(element: .title)

                StyleStack(spacing: \.spacingElements) {

                    Text("Level 2")
                        .style(element: .title)

                    StyleStack(spacing: \.spacingElements) {
                        Text("Level 3")
                            .style(element: .title)
                    }
                    .style(component: component[2])

                }
                .style(component: component[1])

            }
            .style(component: component[0])
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentStackScreen()
}
