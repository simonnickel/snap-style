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

        public enum InteractionState {
            case disabled
            case normal
            case highlighted
            case selected
        }

    }

}
