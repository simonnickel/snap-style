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
    
}


// MARK: - Context

extension SnapStyle.Context {
    
    public var component: SnapStyle.Component { getValue(for: Self.component) ?? .base }
    package static var component: Attribute<String, SnapStyle.Component> { .init(key: "component", valueDefault: .base) }
    
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
            if let containerHierarchy {
                self
                    .style(element: .container, hierarchy: containerHierarchy)
            } else {
                self
            }
        }
        .style(attribute: SnapStyle.Context.component, value: component)
    }
    
}
