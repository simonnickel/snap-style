//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style.Container {

    // TODO: @unchecked Sendable. KeyPath is not Sendable, could be wrapped in a closure.
    /// A description of the style of a container.
    public struct Properties: Hashable, Equatable, @unchecked Sendable {

        public typealias Attribute = Style.Attribute

        public let id: String
        public let requiresSecondaryAccent: Bool
        public let ignoresSafeAreaEdges: Edge.Set

        package let surface: Attribute.Surface.ValueBuilderKeyPath?
        package let composition: Attribute.Composition.ValueBuilderKeyPath?
        package let shape: Attribute.Shape.ValueBuilderKeyPath?
        package let padding: Attribute.Padding.ValueBuilderKeyPath?

        public init(
            _ id: String,
            requiresSecondaryAccent: Bool = false,
            ignoresSafeAreaEdges: Edge.Set = [],
            surface: Attribute.Surface.ValueBuilderKeyPath? = nil,
            composition: Attribute.Composition.ValueBuilderKeyPath? = nil,
            shape: Attribute.Shape.ValueBuilderKeyPath? = nil,
            padding: Attribute.Padding.ValueBuilderKeyPath? = nil,
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
