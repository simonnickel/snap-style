//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    // TODO: @unchecked Sendable. KeyPath is not Sendable, could be wrapped in a closure.
    public struct ContainerDefinition: Hashable, Equatable, @unchecked Sendable {

        public typealias Padding = Style.Padding

        public let id: String
        public let requiresSecondaryAccent: Bool
        public let ignoresSafeAreaEdges: Edge.Set

        package let padding: Padding?
        package let surface: Attributes.Surface.ValueBuilderKeyPath?
        package let composition: Attributes.Composition.ValueBuilderKeyPath?
        package let shape: Attributes.Shape.ValueBuilderKeyPath?

        public init(
            _ id: String,
            requiresSecondaryAccent: Bool = false,
            ignoresSafeAreaEdges: Edge.Set = [],
            padding: Padding? = nil,
            surfaces: Attributes.Surface.ValueBuilderKeyPath? = nil,
            compositions: Attributes.Composition.ValueBuilderKeyPath? = nil,
            shapes: Attributes.Shape.ValueBuilderKeyPath? = nil,
        ) {
            self.id = id
            self.requiresSecondaryAccent = requiresSecondaryAccent
            self.ignoresSafeAreaEdges = ignoresSafeAreaEdges
            self.padding = padding
            self.surface = surfaces
            self.composition = compositions
            self.shape = shapes
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
