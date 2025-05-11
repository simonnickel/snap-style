//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle {
    
    public struct ComponentDefinition: Hashable, Equatable, Sendable {

        public typealias Mapping<Key: StyleKey> = @Sendable (SnapStyle.Element.ElementType) -> Key.ValueBuilderKeyPath?
        public typealias MappingPadding = @Sendable (SnapStyle.Element.ElementType) -> Padding?

        public let id: String
        public let requiresAlternativeAccent: Bool

        internal let padding: MappingPadding?
        internal let fonts: Mapping<FontKey>?
        internal let surfaces: Mapping<SurfaceKey>?
        internal let compositions: Mapping<CompositionKey>?
        internal let shapes: Mapping<ShapeKey>?

        public init(
            _ id: String,
            requiresAlternativeAccent: Bool = false,
            padding: MappingPadding? = nil,
            fonts: Mapping<SnapStyle.FontKey>? = nil,
            surfaces: Mapping<SnapStyle.SurfaceKey>? = nil,
            compositions: Mapping<SnapStyle.CompositionKey>? = nil,
            shapes: Mapping<SnapStyle.ShapeKey>? = nil
        ) {
            self.id = id
            self.requiresAlternativeAccent = requiresAlternativeAccent
            self.padding = padding
            self.fonts = fonts
            self.surfaces = surfaces
            self.compositions = compositions
            self.shapes = shapes
        }
        
        
        // MARK: Padding
        
        public struct Padding {
            
            typealias Value = SnapStyle.NumberKey.ValueBuilderKeyPath
            
            let leading: Value?
            let top: Value?
            let trailing: Value?
            let bottom: Value?
            
            init(_ value: Value, edges: Edge.Set = .all) {
                self.leading = edges.contains(.leading) ? value : nil
                self.top = edges.contains(.top) ? value : nil
                self.trailing = edges.contains(.trailing) ? value : nil
                self.bottom = edges.contains(.bottom) ? value : nil
            }
            
            init(horizontal: Value? = nil, vertical: Value? = nil) {
                self.leading = horizontal
                self.top = vertical
                self.trailing = horizontal
                self.bottom = vertical
            }

            init(leading: Value? = nil, top: Value? = nil, trailing: Value? = nil, bottom: Value? = nil) {
                self.leading = leading
                self.top = top
                self.trailing = trailing
                self.bottom = bottom
            }
            
        }
        
        
        // MARK: Protocols

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
        applyContainer: SnapStyle.Element.Hierarchy? = .primary,
        state: SnapStyle.Component.InteractionState = .normal
    ) -> some View {
        Group {
            if let applyContainer {
                self
                    .style(element: .container, hierarchy: applyContainer)
            } else {
                self
            }
        }
        .modifier(ComponentModifier(component: component, state: state))
    }
    
}

internal struct ComponentModifier: ViewModifier {

    @Environment(\.style) private var style
    
    let component: SnapStyle.ComponentDefinition
    let state: SnapStyle.Component.InteractionState

    func body(content: Content) -> some View {
        let componentStack = style.context.componentStack.appended(component, state: state)
        content
            .style(attribute: SnapStyle.Context.componentStack, value: componentStack)
    }

}
