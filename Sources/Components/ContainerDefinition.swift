//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    // TODO: @unchecked Sendable. KeyPath is not Sendable, could be wrapped in a closure.
    public struct ContainerDefinition: Hashable, Equatable, @unchecked Sendable {

        public let id: String
        public let requiresSecondaryAccent: Bool
        public let ignoresSafeAreaEdges: Edge.Set

        package let padding: Padding?
        package let surface: Keys.Surface.ValueBuilderKeyPath?
        package let composition: Keys.Composition.ValueBuilderKeyPath?
        package let shape: Keys.Shape.ValueBuilderKeyPath?

        public init(
            _ id: String,
            requiresSecondaryAccent: Bool = false,
            ignoresSafeAreaEdges: Edge.Set = [],
            padding: Padding? = nil,
            surfaces: Keys.Surface.ValueBuilderKeyPath? = nil,
            compositions: Keys.Composition.ValueBuilderKeyPath? = nil,
            shapes: Keys.Shape.ValueBuilderKeyPath? = nil,
        ) {
            self.id = id
            self.requiresSecondaryAccent = requiresSecondaryAccent
            self.ignoresSafeAreaEdges = ignoresSafeAreaEdges
            self.padding = padding
            self.surface = surfaces
            self.composition = compositions
            self.shape = shapes
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
            hasher.combine(requiresSecondaryAccent)
            hasher.combine(ignoresSafeAreaEdges.rawValue)
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

    }

}
