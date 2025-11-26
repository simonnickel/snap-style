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


        // MARK: Padding

        public struct Padding {

            public typealias Value = Keys.Number.ValueBuilderKeyPath

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
            hasher.combine(hierarchy)
            hasher.combine(container)
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

    }

}
