//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle {

    /// An actual `Component` instance for a specific View.
    public struct Component {

        package let definition: ComponentDefinition
        package let parent: ComponentDefinition?
        package let state: InteractionState
        package let level: Int

        package init(
            definition: ComponentDefinition,
            parent: ComponentDefinition?,
            state: InteractionState,
            level: Int
        ) {
            self.definition = definition
            self.parent = parent
            self.state = state
            self.level = level
        }

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
