//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct Context: Hashable, Sendable, CaseIterable {

        public let component: Component
        public let item: Item

        /// A context to use for default values.
        static let any: SnapStyle.Context = .init(component: .init(type: .any, hierarchy: .primary), item: .init(type: .any, hierarchy: .primary))

        public static let allCases: [SnapStyle.Context] = {
            var cases: [SnapStyle.Context] = []
            for component in Component.allCases {
                for item in Item.allCases {
                    cases.append(.init(component: component, item: item))
                }
            }

            return cases
        }()

    }

}
