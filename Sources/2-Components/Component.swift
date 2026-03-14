//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    /// Defines the style of a `View` by mapping values for `Style.Attribute`s defined as `ValueBuilderKeyPath` to semantic `ElementType`s.
    public struct Component: Hashable, Equatable, Sendable {

        /// Maps an `ElementType` to a `ValueBuilderKeyPath`, cannot use KeyPath directly, because it is not Sendable.
        public typealias Mapping<Attribute: StyleAttribute> = @Sendable (Style.Element.ElementType) -> Attribute.ValueBuilderKeyPath?

        public let id: String
        public let hierarchy: Hierarchy
        package let container: Style.Container.Properties?

        package let compositions: Mapping<Attribute.Composition>?
        package let fonts: Mapping<Attribute.Font>?
        package let paddings: Mapping<Attribute.Padding>?
        package let shapes: Mapping<Attribute.Shape>?

        public init(
            _ id: String,
            hierarchy: Hierarchy = .primary,
            container: Style.Container.Properties? = nil,
            compositions: Mapping<Attribute.Composition>? = nil,
            fonts: Mapping<Attribute.Font>? = nil,
            paddings: Mapping<Attribute.Padding>? = nil,
            shapes: Mapping<Attribute.Shape>? = nil,
        ) {
            self.id = id
            self.hierarchy = hierarchy
            self.compositions = compositions
            self.fonts = fonts
            self.paddings = paddings
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
