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
        
        // TODO: Remove Keys that do not get applied to elements
        internal let numbers: Mapping<NumberKey>
        internal let fonts: Mapping<FontKey>
        internal let colors: Mapping<ColorKey>
        internal let surfaces: Mapping<SurfaceKey>
        internal let shapes: Mapping<ShapeKey>
        
        public init(
            _ id: ID,
            numbers: @escaping SnapStyle.Component.Mapping<SnapStyle.NumberKey>,
            fonts: @escaping SnapStyle.Component.Mapping<SnapStyle.FontKey>,
            colors: @escaping SnapStyle.Component.Mapping<SnapStyle.ColorKey>,
            surfaces: @escaping SnapStyle.Component.Mapping<SnapStyle.SurfaceKey>,
            shapes: @escaping SnapStyle.Component.Mapping<SnapStyle.ShapeKey>
        ) {
            self.id = id
            self.numbers = numbers
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
    
    public func style(component: SnapStyle.Component, isContainer: Bool = true) -> some View {
        Group {
            if isContainer {
                self
                    .style(element: .container)
            } else {
                self
            }
        }
        .style(attribute: SnapStyle.Context.component, value: component)
    }
    
}
