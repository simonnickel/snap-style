//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    public struct ComponentDefinition: Hashable, Equatable, Sendable {

        public typealias Mapping<Attribute: StyleAttribute> = @Sendable (Style.Element.ElementType) -> Attribute.ValueBuilderKeyPath?
        public typealias MappingPadding = @Sendable (Style.Element.ElementType) -> Padding?
        public typealias Padding = Style.Padding

        public let id: String
        public let hierarchy: Hierarchy

        package let padding: MappingPadding?
        package let fonts: Mapping<Attributes.Font>?
        package let surfaces: Mapping<Attributes.Surface>?
        package let compositions: Mapping<Attributes.Composition>?
        package let shapes: Mapping<Attributes.Shape>?
        package let container: Style.ContainerDefinition?

        public init(
            _ id: String,
            hierarchy: Hierarchy = .primary,
            padding: MappingPadding? = nil,
            fonts: Mapping<Attributes.Font>? = nil,
            surfaces: Mapping<Attributes.Surface>? = nil,
            compositions: Mapping<Attributes.Composition>? = nil,
            shapes: Mapping<Attributes.Shape>? = nil,
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
