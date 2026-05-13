//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    /// Defines the style of a `View` by mapping values for `Style.Attribute`s defined as `ValueBuilderKeyPath` to semantic `ElementType`s.
    public struct Component: Hashable, Equatable, Sendable {

        /// Maps an `ElementType` to a `ValueBuilderKeyPath`.
        public typealias Mapping<Attribute: StyleAttribute> = @Sendable (Style.Element.ElementType) -> Attribute.ValueBuilderKeyPath?

        public let id: String
        public let hierarchy: Hierarchy
        package let container: Style.Container.Properties?
        package let spacing: Style.Attribute.Number.ValueBuilderKeyPathProvider?
        package let compositions: Mapping<Attribute.Composition>?
        package let fonts: Mapping<Attribute.Font>?
        package let paddings: Mapping<Attribute.Padding>?
        package let shapes: Mapping<Attribute.Shape>?

        public init(
            _ id: String,
            hierarchy: Hierarchy = .primary,
            container: Style.Container.Properties? = nil,
            spacing: @autoclosure @escaping @Sendable () -> Style.Attribute.Number.ValueBuilderKeyPath? = nil,
            compositions: Mapping<Attribute.Composition>? = nil,
            fonts: Mapping<Attribute.Font>? = nil,
            paddings: Mapping<Attribute.Padding>? = nil,
            shapes: Mapping<Attribute.Shape>? = nil,
        ) {
            self.id = id
            self.hierarchy = hierarchy
            self.spacing = spacing
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
            lhs.id == rhs.id
            && lhs.hierarchy == rhs.hierarchy
            && lhs.container == rhs.container
        }

        
        // MARK: - Adjusted
        
        /// Creates a copy with adjusted values.
        public func adjusted(
            _ id: String,
            hierarchy: Style.Override<Hierarchy> = .keep,
            container: Style.Override<Style.Container.Properties?> = .keep,
            spacing: Style.Override<Style.Attribute.Number.ValueBuilderKeyPathProvider?> = .keep,
            compositions: Style.Override<Mapping<Attribute.Composition>?> = .keep,
            fonts: Style.Override<Mapping<Attribute.Font>?> = .keep,
            paddings: Style.Override<Mapping<Attribute.Padding>?> = .keep,
            shapes: Style.Override<Mapping<Attribute.Shape>?> = .keep,
        ) -> Self {
            Self(
                id,
                hierarchy: hierarchy.resolved(against: self.hierarchy),
                container: container.resolved(against: self.container),
                spacing: spacing.resolved(against: self.spacing)?(),
                compositions: compositions.resolved(against: self.compositions),
                fonts: fonts.resolved(against: self.fonts),
                paddings: paddings.resolved(against: self.paddings),
                shapes: shapes.resolved(against: self.shapes),
            )
        }
    }

}
