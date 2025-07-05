//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
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

    @Environment(\.style) private var style

    func body(content: Content) -> some View {
        let component = style.context.component.definition
        let element = style.context.element.type

        let base = SnapStyle.ComponentDefinition.base

        let fontKeyPath = component.fonts?(element) ?? base.fonts?(element) ?? \.anyElement
        let padding = component.padding?(element) ?? base.padding?(element) ?? SnapStyle.ComponentDefinition.Padding(\.paddingAnyElement)
        let compositionKeyPath = component.compositions?(element) ?? base.compositions?(element) ?? \.anyElement
        let shapeKeyPath = component.shapes?(element) ?? base.shapes?(element) ?? \.anyElement

        content
            .style(font: fontKeyPath)
            .style(padding: padding.leading ?? \.paddingAnyElement, .leading)
            .style(padding: padding.top ?? \.paddingAnyElement, .top)
            .style(padding: padding.trailing ?? \.paddingAnyElement, .trailing)
            .style(padding: padding.bottom ?? \.paddingAnyElement, .bottom)
            .style(composition: compositionKeyPath)
            .style(shape: shapeKeyPath)
    }

}


// MARK: Hierarchy Modifier

private struct ElementHierarchyModifier: ViewModifier {

    @Environment(\.style) private var style

    let hierarchy: SnapStyle.Element.Hierarchy

    func body(content: Content) -> some View {
        let current = style.context.getValue(for: SnapStyle.Context.element) ?? .any
        let element = SnapStyle.Element(type: current.type, hierarchy: hierarchy)

        let context = style.context
            .withAttribute(value: element, for: SnapStyle.Context.element)

        content
            .style(update: context)
    }

}
