//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct Context: Hashable, Sendable, CaseIterable {

        public let component: Component
        public let hierarchy: Item.Hierarchy

        public static let allCases: [SnapStyle.Context] = {
            var cases: [SnapStyle.Context] = []
            for component in Component.allCases {
                for hierarchy in Item.Hierarchy.allCases {
                    cases.append(.init(component: component, hierarchy: hierarchy))
                }
            }

            return cases
        }()
        
    }

}
