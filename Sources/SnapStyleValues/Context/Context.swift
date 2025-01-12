//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    // TODO: Context could be dictionary with extensions to get actual properties.

    public struct Context: Hashable, Sendable, CaseIterable {

        public let component: Component
        public let element: Element

        /// A context to use for default values.
        public static let any: SnapStyle.Context = .init(component: .init(type: .any, hierarchy: .primary), element: .init(type: .any, hierarchy: .primary))

        public static let allCases: [SnapStyle.Context] = {
            var cases: [SnapStyle.Context] = []
            for component in Component.allCases {
                for element in Element.allCases {
                    cases.append(.init(component: component, element: element))
                }
            }

            return cases
        }()

    }

}
