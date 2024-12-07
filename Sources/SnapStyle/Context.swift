//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct Context: Hashable, Sendable, CaseIterable, CustomStringConvertible {

        public let component: Component
        public let item: Item

        public static let allCases: [SnapStyle.Context] = {
            var cases: [SnapStyle.Context] = []
            for component in Component.allCases {
                for item in Item.allCases {
                    cases.append(.init(component: component, item: item))
                }
            }

            return cases
        }()

        public var description: String {
            component.type.rawValue + "." + component.hierarchy.rawValue + " - " + item.type.rawValue + "." + item.hierarchy.rawValue
        }

    }

}
