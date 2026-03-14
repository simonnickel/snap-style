//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style.Container {

    /// A description of the style of a container.
    public struct Properties: Hashable, Equatable, Sendable {

        public typealias Attribute = Style.Attribute
        
        /// Closure that provides a KeyPath to a ValueBuilder from an Attribute type. Required instead of using KeyPath directly to allow the type to be `Sendable`.
        public typealias KeyPathProvider<Attribute: StyleAttribute> = @Sendable () -> Attribute.ValueBuilderKeyPath

        public let id: String
        public let requiresSecondaryAccent: Bool
        public let ignoresSafeAreaEdges: Edge.Set

        package let surface: KeyPathProvider<Attribute.Surface>?
        package let composition: KeyPathProvider<Attribute.Composition>?
        package let shape: KeyPathProvider<Attribute.Shape>?
        package let padding: KeyPathProvider<Attribute.Padding>?

        public init(
            _ id: String,
            requiresSecondaryAccent: Bool = false,
            ignoresSafeAreaEdges: Edge.Set = [],
            surface: KeyPathProvider<Attribute.Surface>? = nil,
            composition: KeyPathProvider<Attribute.Composition>? = nil,
            shape: KeyPathProvider<Attribute.Shape>? = nil,
            padding: KeyPathProvider<Attribute.Padding>? = nil
        ) {
            self.id = id
            self.requiresSecondaryAccent = requiresSecondaryAccent
            self.ignoresSafeAreaEdges = ignoresSafeAreaEdges
            self.surface = surface
            self.composition = composition
            self.shape = shape
            self.padding = padding
        }


        // MARK: Protocols

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(requiresSecondaryAccent)
            hasher.combine(ignoresSafeAreaEdges.rawValue)
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

    }

}
