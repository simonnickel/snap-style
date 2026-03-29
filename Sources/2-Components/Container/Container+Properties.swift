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

        
        public let id: String
        public let requiresSecondaryAccent: Bool
        public let ignoresSafeAreaEdges: Edge.Set

        package let surface: Attribute.Surface.ValueBuilderKeyPathProvider?
        package let composition: Attribute.Composition.ValueBuilderKeyPathProvider?
        package let shape: Attribute.Shape.ValueBuilderKeyPathProvider?
        package let padding: Attribute.Padding.ValueBuilderKeyPathProvider?

        public init(
            _ id: String,
            requiresSecondaryAccent: Bool = false,
            ignoresSafeAreaEdges: Edge.Set = [],
            surface: @autoclosure @escaping @Sendable () -> Attribute.Surface.ValueBuilderKeyPath? = nil,
            composition: @autoclosure @escaping @Sendable () -> Attribute.Composition.ValueBuilderKeyPath? = nil,
            shape: @autoclosure @escaping @Sendable () -> Attribute.Shape.ValueBuilderKeyPath? = nil,
            padding: @autoclosure @escaping @Sendable () -> Attribute.Padding.ValueBuilderKeyPath? = nil
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
            lhs.id == rhs.id
            && lhs.requiresSecondaryAccent == rhs.requiresSecondaryAccent
            && lhs.ignoresSafeAreaEdges == rhs.ignoresSafeAreaEdges
        }

    }

}
