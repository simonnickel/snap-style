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

            let components: [SnapStyle.ComponentDefinition] = [.screen, .content, .card, .action]
            
            ForEach(components, id: \.self) { component in
                contentComponent(component)
            }

        }
        .navigationTitle("Components")
    }
    
    @ViewBuilder
    private func contentComponent(_ component: SnapStyle.ComponentDefinition) -> some View {
        VStack(alignment: .leading) {
            Text("\(component.id), .primary")
            HStack {
                ElementStackView(hierarchy: .primary)
                ElementStackView(hierarchy: .secondary)
            }
        }
        .style(component: component)
    }

}

#Preview {
    NavigationStack {
        ComponentsScreen()
    }
}
