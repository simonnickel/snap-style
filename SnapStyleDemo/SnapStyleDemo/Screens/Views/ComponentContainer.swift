//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct ComponentContainer<Content: View>: View {

    let title: String
    let component: SnapStyle.ComponentDefinition
    @ViewBuilder let content: () -> Content

    var body: some View {
        StyleStack(spacing: \.spacingElements) {
            Text(title)
                .style(element: .title)
            content()
        }
        .style(component: component)
    }
}


// MARK: - Preview

#Preview {
    StyleScreen {
        ComponentContainer(title: "Preview", component: .contentCard) {
            Text("Content Card")
        }
        ComponentContainer(title: "Preview", component: .accentCard) {
            Text("Accent Card")
        }
    }
}
