//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle {
    
    public struct ComponentDefinition: Identifiable, Hashable, Equatable, Sendable {

        public typealias Mapping<Key: StyleKey> = @Sendable (SnapStyle.Element.ElementType) -> Key.ValueBuilderKeyPath?

        // TODO: Merge into a Config struct?
        public let id: String // TODO: This ID is not really robust
        public let requiresAlternativeAccent: Bool

        internal let padding: Mapping<NumberKey>?
        internal let fonts: Mapping<FontKey>?
        internal let colors: Mapping<ColorKey>?
        internal let surfaces: Mapping<SurfaceKey>?
        internal let shapes: Mapping<ShapeKey>?

        public init(
            _ id: ID,
            requiresAlternativeAccent: Bool = false,
            padding: SnapStyle.ComponentDefinition.Mapping<SnapStyle.NumberKey>? = nil,
            fonts: SnapStyle.ComponentDefinition.Mapping<SnapStyle.FontKey>? = nil,
            colors: SnapStyle.ComponentDefinition.Mapping<SnapStyle.ColorKey>? = nil,
            surfaces: SnapStyle.ComponentDefinition.Mapping<SnapStyle.SurfaceKey>? = nil,
            shapes: SnapStyle.ComponentDefinition.Mapping<SnapStyle.ShapeKey>? = nil
        ) {
            self.id = id
            self.requiresAlternativeAccent = requiresAlternativeAccent
            self.padding = padding
            self.fonts = fonts
            self.colors = colors
            self.surfaces = surfaces
            self.shapes = shapes
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        public static func == (lhs: SnapStyleBase.SnapStyle.ComponentDefinition, rhs: SnapStyleBase.SnapStyle.ComponentDefinition) -> Bool {
            lhs.id == rhs.id // TODO: Necessary? Not robust.
        }

    }

}


// MARK: - Context

extension SnapStyle.Context {
    
    package var componentStack: SnapStyle.ComponentStack { getValue(for: Self.componentStack) ?? .init() }
    package static var componentStack: Attribute<String, SnapStyle.ComponentStack> { .init(key: "componentStack", valueDefault: .init()) }

    // TODO: Should return a struct (state, level, definition) to allow if context.component.state
    public var component: SnapStyle.ComponentDefinition { componentStack.current ?? .base }
    public var componentState: SnapStyle.ComponentDefinition.InteractionState { componentStack.currentState ?? .normal }
    public var useAlternativeAccent: Bool { componentStack.parent?.requiresAlternativeAccent ?? false }
    
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
        state: SnapStyle.ComponentDefinition.InteractionState = .normal
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
    let state: SnapStyle.ComponentDefinition.InteractionState

    func body(content: Content) -> some View {
        var componentStack = styleContext.componentStack.appended(component, state: state)
        content
            .style(attribute: SnapStyle.Context.componentStack, value: componentStack)
    }

}
