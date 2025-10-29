//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

// MARK: - Element

extension View {
    
    /// Apply styling defined for `ElementType`.
    /// - Parameters:
    ///   - element: The `ElementType` the view represents.
    ///   - hierarchy: `Hierarchy` of the element.
    public func style(element: Style.Element.ElementType, hierarchy: Style.Element.Hierarchy = .primary) -> some View {
        self
            .modifier(ElementApplyStyleModifier())
            .style(attribute: Style.Context.element, value: Style.Element(type: element, hierarchy: hierarchy))
    }

    /// Shortcut to adjust the elements hierarchy.
    public func style(hierarchy: Style.Element.Hierarchy = .primary) -> some View {
        self
            .modifier(ElementApplyStyleModifier())
            .modifier(ElementHierarchyModifier(hierarchy: hierarchy))
    }
    
    // TODO: Move somewhere else?
    public func style(container: Style.ContainerDefinition, hierarchy: Style.Element.Hierarchy = .primary) -> some View {
        self
            .modifier(ContainerApplyStyleModifier(container: container))
            .modifier(ElementHierarchyModifier(hierarchy: hierarchy))
    }

}


// MARK: ElementApplyStyleModifier

private struct ElementApplyStyleModifier: ViewModifier {

    @Environment(\.style) private var style

    func body(content: Content) -> some View {
        let component = style.context.component
        let element = style.context.element.type

        let base = Style.ComponentDefinition.base

        let fontKeyPath = component.fonts?(element) ?? base.fonts?(element) ?? \.anyElement
        let padding = component.padding?(element) ?? base.padding?(element) ?? Style.ComponentDefinition.Padding(\.paddingAnyElement)
        let compositionKeyPath = component.compositions?(element) ?? base.compositions?(element) ?? \.anyElement
        // TODO: Should Shape still be here anyway?
//        let shapeKeyPath = component.shapes?(element) ?? base.shapes?(element) ?? \.anyElement

        content
            .style(font: fontKeyPath)
            .style(padding: padding.leading ?? \.paddingAnyElement, .leading)
            .style(padding: padding.top ?? \.paddingAnyElement, .top)
            .style(padding: padding.trailing ?? \.paddingAnyElement, .trailing)
            .style(padding: padding.bottom ?? \.paddingAnyElement, .bottom)
            .style(composition: compositionKeyPath)
//            .style(shape: shapeKeyPath)
    }

}


// MARK: ContainerApplyStyleModifier

// TODO: Move somewhere else?
private struct ContainerApplyStyleModifier: ViewModifier {

    @Environment(\.style) private var style
    
    let container: Style.ContainerDefinition

    func body(content: Content) -> some View {
        let base = Style.ContainerDefinition.base

        let padding = container.padding ?? base.padding ?? Style.ContainerDefinition.Padding(\.paddingAnyElement)
        let compositionKeyPath = container.compositions ?? base.compositions ?? \.anyElement
        let shapeKeyPath = container.shapes ?? base.shapes ?? \.anyElement

        content
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

    let hierarchy: Style.Element.Hierarchy

    func body(content: Content) -> some View {
        let current = style.context.getValue(for: Style.Context.element) ?? .any
        let element = Style.Element(type: current.type, hierarchy: hierarchy)

        let context = style.context
            .withAttribute(value: element, for: Style.Context.element)

        content
            .style(update: context)
    }

}
