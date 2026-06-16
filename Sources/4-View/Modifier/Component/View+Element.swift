//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

// MARK: - Element

extension View {
    
    /// Applies styling for the element with hierarchy.
    /// - Parameters:
    ///   - element:`ElementType` the view represents and is styled after.
    ///   - hierarchy: `Hierarchy` of the element.
    /// - Returns: View with applied styling and modified `Context`.
    public func style(element: Style.Element.ElementType, hierarchy: Style.Element.Hierarchy = .primary) -> some View {
        self
            .modifier(ElementApplyStyleModifier())
            .style(attribute: Style.Context.element, value: Style.Element(type: element, hierarchy: hierarchy))
    }

    /// Applies styling for the element from context, adjusting the hierarchy.
    /// - Parameter hierarchy: `Hierarchy` of the element.
    /// - Returns: View with applied styling and modified `Context`.
    public func style(hierarchy: Style.Element.Hierarchy = .primary) -> some View {
        self
            .modifier(ElementApplyStyleModifier())
            .modifier(ElementHierarchyModifier(hierarchy: hierarchy))
    }

}


// MARK: ElementApplyStyleModifier

private struct ElementApplyStyleModifier: ViewModifier {

    @Environment(\.style) private var style

    func body(content: Content) -> some View {
        let element = style.context.element.type

        content
            .style(apply: Style.Attribute.Font.self, for: element)
            .style(apply: Style.Attribute.Padding.self, for: element)
            .style(apply: Style.Attribute.Composition.self, for: element)
            .style(apply: Style.Attribute.Shape.self, for: element)
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
