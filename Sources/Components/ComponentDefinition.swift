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
        public typealias Padding = Style.Padding

        public let id: String
        public let hierarchy: Hierarchy

        package let padding: MappingPadding?
        package let fonts: Mapping<Keys.Font>?
        package let surfaces: Mapping<Keys.Surface>?
        package let compositions: Mapping<Keys.Composition>?
        package let shapes: Mapping<Keys.Shape>?
        package let container: Style.ContainerDefinition?

        public init(
            _ id: String,
            hierarchy: Hierarchy = .primary,
            padding: MappingPadding? = nil,
            fonts: Mapping<Keys.Font>? = nil,
            surfaces: Mapping<Keys.Surface>? = nil,
            compositions: Mapping<Keys.Composition>? = nil,
            shapes: Mapping<Keys.Shape>? = nil,
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
