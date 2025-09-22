//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

public struct DebugComponentsScreen: View {

    @State private var component: Style.ComponentDefinition = .screen

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
            }
        }
    }

    private var element: some View {
        StyleStack(spacing: \.spacingSections) {
            ForEach(Style.Element.Hierarchy.allCases) { hierarchy in
                StyleStack {
                    DebugElementsView(hierarchy: hierarchy)
                }
                .style(component: component ?? .screen)
            }
        }
    }

}

#Preview {
    DebugComponentsScreen(components: [.base, .screen, .contentCard, .accentCard, .metricCard, .list, .listRow])
}
