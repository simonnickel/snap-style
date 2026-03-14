//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// Needs to be located in `Definitions` target to have access to `.base`.

extension Style.Context {

    package var component: Style.Component { getValue(for: Self.component) ?? .base }
    
    package static var component: Attribute<String, Style.Component> { .init(key: "component", valueDefault: .base) }

}
