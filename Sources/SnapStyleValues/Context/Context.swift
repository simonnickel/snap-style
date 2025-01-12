//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    // TODO: Context could be dictionary with extensions to get actual properties.

    public struct Context: Hashable, Sendable {

        public let component: Component
        public let element: Element

        /// A context to use for default values.
        public static let any: SnapStyle.Context = .init(component: .init(type: .any, hierarchy: .primary), element: .init(type: .any, hierarchy: .primary))

    }

}
