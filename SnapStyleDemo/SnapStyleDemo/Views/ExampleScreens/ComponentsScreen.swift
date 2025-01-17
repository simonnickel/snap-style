//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct ComponentsScreen: View {
    
    var body: some View {
        ScrollView {

            let components = SnapStyle.Component.ComponentType.allCases.filter({ ![.any, .screen].contains($0) })
            
            ForEach(components, id: \.self) { component in
                contentComponent(component)
            }

        }
        .style(component: .screen)
    }
    
    @ViewBuilder
    private func contentComponent(_ type: SnapStyle.Component.ComponentType) -> some View {
        VStack(alignment: .leading) {
            Text("\(type), .primary")
            contentElements(hierarchy: .primary)
            contentElements(hierarchy: .secondary)
            contentComponentSecondary(type)
        }
        .padding() // TODO: Style?
        .style(component: type, hierarchy: .primary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func contentComponentSecondary(_ type: SnapStyle.Component.ComponentType) -> some View {
        VStack(alignment: .leading) {
            Text("\(type), .secondary")
            contentElements(hierarchy: .primary)
            contentElements(hierarchy: .secondary)
        }
        .padding() // TODO: Style?
        .style(component: type, hierarchy: .secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func contentElements(hierarchy: SnapStyle.Element.Hierarchy) -> some View {
        HStack(alignment: .firstTextBaseline) {
            ForEach(SnapStyle.Element.ElementType.allCases, id: \.self) { elementType in
                Text("\(elementType)")
                    .style(element: elementType, hierarchy: hierarchy)
            }
        }
    }

}

#Preview {
    ComponentsScreen()
}
