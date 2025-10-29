//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension Style {

    /// An actual `Component` instance for a specific View.
    public struct Component {

        package let definition: ComponentDefinition
        package let parent: ComponentDefinition?
        package let level: Int

        package init(
            definition: ComponentDefinition,
            parent: ComponentDefinition?,
            level: Int
        ) {
            self.definition = definition
            self.parent = parent
            self.level = level
        }

    }

}
