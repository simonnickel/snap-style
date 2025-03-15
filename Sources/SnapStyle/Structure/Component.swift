//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle {
    
    public struct Component: Identifiable, Hashable, Equatable, Sendable {
        
        public typealias Mapping<Key: StyleKey> = @Sendable (SnapStyle.Element.ElementType) -> Key.ValueBuilderKeyPath?
        
        public let id: String
        
        internal let padding: Mapping<NumberKey>?
        internal let fonts: Mapping<FontKey>?
        internal let colors: Mapping<ColorKey>?
        internal let surfaces: Mapping<SurfaceKey>?
        internal let shapes: Mapping<ShapeKey>?
        
        public init(
            _ id: ID,
            padding: SnapStyle.Component.Mapping<SnapStyle.NumberKey>? = nil,
            fonts: SnapStyle.Component.Mapping<SnapStyle.FontKey>? = nil,
            colors: SnapStyle.Component.Mapping<SnapStyle.ColorKey>? = nil,
            surfaces: SnapStyle.Component.Mapping<SnapStyle.SurfaceKey>? = nil,
            shapes: SnapStyle.Component.Mapping<SnapStyle.ShapeKey>? = nil
        ) {
            self.id = id
            self.padding = padding
            self.fonts = fonts
            self.colors = colors
            self.surfaces = surfaces
            self.shapes = shapes
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        public static func == (lhs: SnapStyleBase.SnapStyle.Component, rhs: SnapStyleBase.SnapStyle.Component) -> Bool {
            lhs.id == rhs.id
        }
        
    }
    
    
    // MARK: ComponentStack
    
    package struct ComponentStack: Hashable {
        
        private var components: [SnapStyle.Component] = []
        
        var current: Component? { components.last }
        
        /// Level of components independent of `Component`.
        var levelOverall: Int {
            components.count - 1
        }
        
        /// Level of consistent `Component` stacked without interruption.
        var level: Int {
            var result = 1
            var index = components.count - 1
            var continueLoop: Bool = true
            while continueLoop && index > 0 {
                index -= 1
                let parentComponent = components[index]
                if parentComponent == current {
                    result += 1
                } else {
                    continueLoop = false
                }
            }
            
            return result
        }
        
        func appended(_ component: SnapStyle.Component) -> Self {
            var result = self
            result.components.append(component)
            return result
        }
        
    }
    
}


// MARK: - Context

extension SnapStyle.Context {
    
    package var componentStack: SnapStyle.ComponentStack { getValue(for: Self.componentStack) ?? .init() }
    package static var componentStack: Attribute<String, SnapStyle.ComponentStack> { .init(key: "componentStack", valueDefault: .init()) }
    
    public var component: SnapStyle.Component { componentStack.current ?? .base }
    
}


// MARK: - Component+View

extension View {
    
    /// Defines the View as a component to use it's style definition and draw the container.
    /// - Parameters:
    ///   - component: Definition to use for the component.
    ///   - containerHierarchy: Level of container that should be used. Set to nil if no container should be visible.
    /// - Returns: A modified View.
    public func style(component: SnapStyle.Component, containerHierarchy: SnapStyle.Element.Hierarchy? = .primary) -> some View {
        Group {
            // TODO: Should containerHierarchy still be a thing?
            if let containerHierarchy {
                self
                    .style(element: .container, hierarchy: containerHierarchy)
            } else {
                self
            }
        }
        .modifier(ComponentModifier(component: component))
    }
    
}

internal struct ComponentModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let component: SnapStyle.Component

    func body(content: Content) -> some View {
        var componentStack = styleContext.componentStack.appended(component)
        content
            .style(attribute: SnapStyle.Context.componentStack, value: componentStack)
    }

}
