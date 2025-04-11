//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle {

    /// An actual `Component` instance for a specific View.
    public struct Component {

        let definition: ComponentDefinition
        let parent: ComponentDefinition?
        let state: InteractionState
        let level: Int

        public var useAlternativeAccent: Bool { parent?.requiresAlternativeAccent ?? false }


        // MARK: - InteractionState

        public enum InteractionState: Comparable {
            case disabled
            case normal
            case highlighted
            case selected

            private var priority: Int {
                switch self {
                    case .disabled: 0
                    case .selected: 1
                    case .highlighted: 2
                    case .normal: 3
                }
            }

            public static func <(lhs: InteractionState, rhs: InteractionState) -> Bool {
                lhs.priority > rhs.priority
            }
        }

    }

}
