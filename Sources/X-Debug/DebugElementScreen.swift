//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

public struct DebugElementScreen: View {

    @State private var component: Style.ComponentDefinition = .screen
    @State private var elementType: Style.Element.ElementType = .any
    @State private var elementHierarchy: Style.Element.Hierarchy = .primary

    private let components: [Style.ComponentDefinition]
    
    public init(components: [Style.ComponentDefinition]) {
        self.components = components
    }

    public var body: some View {
        StyleScreen {
            config
            element
        }
    }

    private var config: some View {
        VStack {
            HStack {
                Picker("Component", selection: $component) {
                    ForEach(components, id: \.self) { component in
                        Text("\(component)")
                    }
                }
                Picker("Element", selection: $elementType) {
                    ForEach(Style.Element.ElementType.allCases, id: \.self) { element in
                        Text("\(element)")
                    }
                }
                Picker("Hierarchy", selection: $elementHierarchy) {
                    ForEach(Style.Element.Hierarchy.allCases, id: \.self) { hierarchy in
                        Text("\(hierarchy)")
                    }
                }
            }
        }
    }

    private var element: some View {
        StyleStack {
            Text("Element")
                .style(element: elementType, hierarchy: elementHierarchy)
        }
        .style(component: component ?? .screen)
    }

}

#Preview {
    DebugElementScreen(components: [.screen, .contentCard, .accentCard, .metricCard, .list, .listRow])
}
