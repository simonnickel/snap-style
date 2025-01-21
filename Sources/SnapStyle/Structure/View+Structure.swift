//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI


// MARK: - Component

extension View {
    
    public func style(component: SnapStyle.Component.ComponentType, hierarchy: SnapStyle.Component.Hierarchy = .primary, applyStyle: Bool = true) -> some View {
        Group {
            if applyStyle {
                self.applyComponentStyle()
            } else {
                self
            }
        }
        .style(attribute: SnapStyle.Context.component, value: SnapStyle.Component(type: component, hierarchy: hierarchy))
    }
    
    private func applyComponentStyle() -> some View {
        self
            .style(padding: \.paddingComponent, .all)
            .style(surface: \.component)
            .style(font: \.component)
            .style(shape: \.componentContainer)
    }

}
    

// MARK: - Element

extension View {
    
    public func style(element: SnapStyle.Element.ElementType, hierarchy: SnapStyle.Element.Hierarchy = .primary, applyStyle: Bool = true) -> some View {
        Group {
            if applyStyle {
                self.applyElementStyle()
            } else {
                self
            }
        }
        .style(attribute: SnapStyle.Context.element, value: SnapStyle.Element(type: element, hierarchy: hierarchy))
    }
    
    /// Shortcut to adjust the elements hierarchy.
    public func style(hierarchy: SnapStyle.Element.Hierarchy = .primary) -> some View {
        self
            .applyElementStyle()
            .modifier(ElementHierarchyModifier(hierarchy: hierarchy))
    }
    
    private func applyElementStyle() -> some View {
        self
            .style(font: \.element)
            .style(surface: \.element)
    }
    
}


// MARK: Hierarchy Modifier

private struct ElementHierarchyModifier: ViewModifier {
    
    @Environment(\.styleContext) private var context

    let hierarchy: SnapStyle.Element.Hierarchy

    func body(content: Content) -> some View {
        let current = context.getValue(for: SnapStyle.Context.element) ?? .any
        let element = SnapStyle.Element(type: current.type, hierarchy: hierarchy)
        
        let modified = context
            .withAttribute(value: element, for: SnapStyle.Context.element)
        
        content
            .environment(\.styleContext, modified)
    }
    
}
