//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    public struct ComponentDefinition: Hashable, Equatable, Sendable {

        public typealias Mapping<Key: StyleKey> = @Sendable (Style.Element.ElementType) -> Key.ValueBuilderKeyPath?
        public typealias MappingPadding = @Sendable (Style.Element.ElementType) -> Padding?

        public let id: String
        public let requiresSecondaryAccent: Bool

        package let padding: MappingPadding?
        package let fonts: Mapping<FontKey>?
        package let surfaces: Mapping<SurfaceKey>?
        package let compositions: Mapping<CompositionKey>?
        package let shapes: Mapping<ShapeKey>?

        public init(
            _ id: String,
            requiresSecondaryAccent: Bool = false,
            padding: MappingPadding? = nil,
            fonts: Mapping<Style.FontKey>? = nil,
            surfaces: Mapping<Style.SurfaceKey>? = nil,
            compositions: Mapping<Style.CompositionKey>? = nil,
            shapes: Mapping<Style.ShapeKey>? = nil
        ) {
            self.id = id
            self.requiresSecondaryAccent = requiresSecondaryAccent
            self.padding = padding
            self.fonts = fonts
            self.surfaces = surfaces
            self.compositions = compositions
            self.shapes = shapes
        }


        // MARK: Padding

        public struct Padding {

            public typealias Value = Style.NumberKey.ValueBuilderKeyPath

            package let leading: Value?
            package let top: Value?
            package let trailing: Value?
            package let bottom: Value?

            public init(_ value: Value, edges: Edge.Set = .all) {
                self.leading = edges.contains(.leading) ? value : nil
                self.top = edges.contains(.top) ? value : nil
                self.trailing = edges.contains(.trailing) ? value : nil
                self.bottom = edges.contains(.bottom) ? value : nil
            }

            public init(horizontal: Value? = nil, vertical: Value? = nil) {
                self.leading = horizontal
                self.top = vertical
                self.trailing = horizontal
                self.bottom = vertical
            }

            public init(leading: Value? = nil, top: Value? = nil, trailing: Value? = nil, bottom: Value? = nil) {
                self.leading = leading
                self.top = top
                self.trailing = trailing
                self.bottom = bottom
            }

        }


        // MARK: Protocols

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(requiresSecondaryAccent)
        }

        public static func == (lhs: SnapStyleBase.Style.ComponentDefinition, rhs: SnapStyleBase.Style.ComponentDefinition) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

    }

}
