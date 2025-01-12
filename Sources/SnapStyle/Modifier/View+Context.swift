//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    
    // MARK: - Component

    public func style(component: SnapStyle.Component.ComponentType, hierarchy: SnapStyle.Component.Hierarchy = .primary) -> some View {
        self
            .style(attribute: SnapStyle.Context.component, value: SnapStyle.Component(type: component, hierarchy: hierarchy))
    }
    
    
    // MARK: - Element
    
    public func style(element: SnapStyle.Element.ElementType, hierarchy: SnapStyle.Element.Hierarchy = .primary, applyStyle: Bool = true) -> some View {
        Group {
            if applyStyle {
                self
                    .modifier(FontFromEnvironmentModifier())
                    .modifier(SurfaceFromEnvironmentModifier(layer: .foreground))
                    .modifier(SurfaceFromEnvironmentModifier(layer: .background))
            } else {
                self
            }
        }
        .style(attribute: SnapStyle.Context.element, value: SnapStyle.Element(type: element, hierarchy: hierarchy))
    }

}
