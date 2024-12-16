//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

extension View {
    
    
    // MARK: - Component

    public func style(component: SnapStyle.Component.ComponentType, hierarchy: SnapStyle.Component.Hierarchy = .primary) -> some View {
        self
            .environment(\.styleComponent, .init(type: component, hierarchy: hierarchy))
    }
    
    
    // MARK: - Item
    
    public func style(item: SnapStyle.Item.ItemType, hierarchy: SnapStyle.Item.Hierarchy = .primary, applyStyle: Bool = true) -> some View {
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
        .environment(\.styleItem, SnapStyle.Item(type: item, hierarchy: hierarchy))
    }

}
