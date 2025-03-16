//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct ComponentsScreen: View {
    
    var body: some View {
        StyleScreen {

            let components: [SnapStyle.Component] = [.screen, .content, .card, .action]
            
            ForEach(components, id: \.self) { component in
                contentComponent(component)
            }

        }
        .navigationTitle("Components")
    }
    
    @ViewBuilder
    private func contentComponent(_ component: SnapStyle.Component) -> some View {
        VStack(alignment: .leading) {
            Text("\(component.id), .primary")
            HStack {
                ElementStackView(hierarchy: .primary)
                ElementStackView(hierarchy: .secondary)
                contentStates()
            }
        }
        .style(component: component)
    }
    
    @ViewBuilder
    private func contentStates() -> some View {
        VStack(alignment: .leading) {
            Text("Highlighted Element")
                .style(surface: \.highlightedElement)
            Text("Highlighted Container")
                .style(surface: \.highlightedContainer)
            Text("Disabled Element")
                .style(surface: \.disabledElement)
            Text("Disabled Container")
                .style(surface: \.disabledContainer)
        }
    }

}

#Preview {
    NavigationStack {
        ComponentsScreen()
    }
}
