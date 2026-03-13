//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    /// Defines the style of a `View` by mapping values for `Style.Attribute`s defined as `ValueBuilderKeyPath` to semantic `ElementType`s.
    public struct Component: Hashable, Equatable, Sendable {

        /// Maps an `ElementType` to a `ValueBuilderKeyPath`
        public typealias Mapping<Attribute: StyleAttribute> = @Sendable (Style.Element.ElementType) -> Attribute.ValueBuilderKeyPath?
        
        public typealias Padding = Style.Padding
        public typealias MappingPadding = @Sendable (Style.Element.ElementType) -> Padding?

        public let id: String
        public let hierarchy: Hierarchy

        package let padding: MappingPadding?
        package let fonts: Mapping<Attribute.Font>?
        package let surfaces: Mapping<Attribute.Surface>?
        package let compositions: Mapping<Attribute.Composition>?
        package let shapes: Mapping<Attribute.Shape>?
        package let container: Style.ContainerDefinition?

        public init(
            _ id: String,
            hierarchy: Hierarchy = .primary,
            padding: MappingPadding? = nil,
            fonts: Mapping<Attribute.Font>? = nil,
            surfaces: Mapping<Attribute.Surface>? = nil,
            compositions: Mapping<Attribute.Composition>? = nil,
            shapes: Mapping<Attribute.Shape>? = nil,
            container: Style.ContainerDefinition? = nil,
        ) {
            self.id = id
            self.hierarchy = hierarchy
            self.padding = padding
            self.fonts = fonts
            self.surfaces = surfaces
            self.compositions = compositions
            self.shapes = shapes
            self.container = container
        }


        // MARK: Hierarchy

        public enum Hierarchy: String, Identifiable, Sendable, CaseIterable {

            case any

            case primary
            case secondary
            case tertiary

            public var id: String { rawValue }

        }


        // MARK: Protocols

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(hierarchy)
            hasher.combine(container)
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

    }

}
