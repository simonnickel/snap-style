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

    @State private var component: Style.Component = .screen

    private let components: [Style.Component]
    
    public init(components: [Style.Component]) {
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
                        Text("\(component.description)")
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
                .style(component: component)
            }
        }
    }

}

#Preview {
    DebugComponentsScreen(components: [.base, .screen, .contentCard, .accentCard, .metricCard, .list, .listRow])
}
