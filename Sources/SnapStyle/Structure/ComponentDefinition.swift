//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle {
    
    public struct ComponentDefinition: Hashable, Equatable, Sendable {

        public typealias Mapping<Key: StyleKey> = @Sendable (SnapStyle.Element.ElementType) -> Key.ValueBuilderKeyPath?

        // TODO: Merge into a Config struct?
        public let id: String
        public let requiresAlternativeAccent: Bool

        internal let padding: Mapping<NumberKey>?
        internal let fonts: Mapping<FontKey>?
        internal let surfaces: Mapping<SurfaceKey>?
        internal let compositions: Mapping<CompositionKey>?
        internal let shapes: Mapping<ShapeKey>?

        public init(
            _ id: String,
            requiresAlternativeAccent: Bool = false,
            padding: SnapStyle.ComponentDefinition.Mapping<SnapStyle.NumberKey>? = nil,
            fonts: SnapStyle.ComponentDefinition.Mapping<SnapStyle.FontKey>? = nil,
            surfaces: SnapStyle.ComponentDefinition.Mapping<SnapStyle.SurfaceKey>? = nil,
            compositions: SnapStyle.ComponentDefinition.Mapping<SnapStyle.CompositionKey>? = nil,
            shapes: SnapStyle.ComponentDefinition.Mapping<SnapStyle.ShapeKey>? = nil
        ) {
            self.id = id
            self.requiresAlternativeAccent = requiresAlternativeAccent
            self.padding = padding
            self.fonts = fonts
            self.surfaces = surfaces
            self.compositions = compositions
            self.shapes = shapes
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(requiresAlternativeAccent)
        }

        public static func == (lhs: SnapStyleBase.SnapStyle.ComponentDefinition, rhs: SnapStyleBase.SnapStyle.ComponentDefinition) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

    }

}


// MARK: - Component+View

extension View {
    
    /// Defines the View as a component to use it's style definition and draw the container.
    /// - Parameters:
    ///   - component: Definition to use for the component.
    ///   - containerHierarchy: Level of `.container` that should be used. Set to nil if no container should be visible.
    /// - Returns: A modified View.
    public func style(
        component: SnapStyle.ComponentDefinition,
        containerHierarchy: SnapStyle.Element.Hierarchy? = .primary,
        state: SnapStyle.Component.InteractionState = .normal
    ) -> some View {
        Group {
            if let containerHierarchy {
                self
                    .style(element: .container, hierarchy: containerHierarchy)
            } else {
                self
            }
        }
        .modifier(ComponentModifier(component: component, state: state))
    }
    
}

internal struct ComponentModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let component: SnapStyle.ComponentDefinition
    let state: SnapStyle.Component.InteractionState

    func body(content: Content) -> some View {
        var componentStack = styleContext.componentStack.appended(component, state: state)
        content
            .style(attribute: SnapStyle.Context.componentStack, value: componentStack)
    }

}
