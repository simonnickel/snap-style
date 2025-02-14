//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI


// MARK: - Element

extension View {
    
    public func style(element: SnapStyle.Element.ElementType, hierarchy: SnapStyle.Element.Hierarchy = .primary, applyStyle: Bool = true) -> some View {
        Group {
            if applyStyle {
                self.modifier(ElementApplyStyleModifier())
            } else {
                self
            }
        }
        .style(attribute: SnapStyle.Context.element, value: SnapStyle.Element(type: element, hierarchy: hierarchy))
    }
    
    /// Shortcut to adjust the elements hierarchy.
    public func style(hierarchy: SnapStyle.Element.Hierarchy = .primary) -> some View {
        self
            .modifier(ElementApplyStyleModifier())
            .modifier(ElementHierarchyModifier(hierarchy: hierarchy))
    }
    
}


// MARK: ElementApplyStyleModifier

private struct ElementApplyStyleModifier: ViewModifier {
    
    @Environment(\.styleContext) private var context

    func body(content: Content) -> some View {
        let component = context.component
        let element = context.element.type
        
        let fontKeyPath = component.fonts(element) ?? SnapStyle.Component.base.fonts(element) ?? \.anyElement
        let paddingKeyPath = component.padding(element) ?? SnapStyle.Component.base.padding(element) ?? \.paddingAnyElement
        let surfaceKeyPath = component.surfaces(element) ?? SnapStyle.Component.base.surfaces(element) ?? \.anyElement
        let shapeKeyPath = component.shapes(element) ?? SnapStyle.Component.base.shapes(element) ?? \.anyElement
        
        content
            .style(font: fontKeyPath)
            .style(padding: paddingKeyPath)
            .style(surface: surfaceKeyPath)
            .style(shape: shapeKeyPath)
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
