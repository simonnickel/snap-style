//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// Needs to be located in `Definitions` target to have access to `Component.base`.

extension Style.Context {

    package var component: Style.ComponentDefinition { getValue(for: Self.component) ?? .base }
    
    package static var component: Attribute<String, Style.ComponentDefinition> { .init(key: "component", valueDefault: .base) }

}
