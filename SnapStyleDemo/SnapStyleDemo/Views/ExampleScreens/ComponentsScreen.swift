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

            // TODO: Preview Example of new Components
//            let components = SnapStyle.Component.ComponentType.allCases.filter({ ![.any].contains($0) })
//            
//            ForEach(components, id: \.self) { component in
//                contentComponent(component)
//            }

        }
        .navigationTitle("Components")
    }
    
//    @ViewBuilder
//    private func contentComponent(_ type: SnapStyle.Component.ComponentType) -> some View {
//        VStack(alignment: .leading) {
//            Text("\(type), .primary")
//            contentElements(hierarchy: .primary)
//            contentElements(hierarchy: .secondary)
//            contentComponentSecondary(type)
//            contentStates()
//        }
//        .style(component: type, hierarchy: .primary)
//    }
//    
//    @ViewBuilder
//    private func contentComponentSecondary(_ type: SnapStyle.Component.ComponentType) -> some View {
//        VStack(alignment: .leading) {
//            Text("\(type), .secondary")
//                .frame(maxWidth: .infinity, alignment: .leading)
//            contentElements(hierarchy: .primary)
//            contentElements(hierarchy: .secondary)
//        }
//        .style(component: type, hierarchy: .secondary)
//    }
    
    @ViewBuilder
    private func contentElements(hierarchy: SnapStyle.Element.Hierarchy) -> some View {
        HStack(alignment: .firstTextBaseline) {
            ForEach(SnapStyle.Element.ElementType.allCases, id: \.self) { elementType in
                Text("\(elementType)")
                    .style(element: elementType, hierarchy: hierarchy)
            }
        }
    }
    
    @ViewBuilder
    private func contentStates() -> some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                HStack {
                    Text("Highlighted Element")
                        .style(surface: \.highlightedElement)
                    Text("Highlighted Container")
                        .style(surface: \.highlightedContainer)
                }
            }
            
            VStack {
                HStack {
                    Text("Disabled Element")
                        .style(surface: \.disabledElement)
                    Text("Disabled Container")
                        .style(surface: \.disabledContainer)
                }
            }
            
        }
    }

}

#Preview {
    NavigationStack {
        ComponentsScreen()
    }
}
