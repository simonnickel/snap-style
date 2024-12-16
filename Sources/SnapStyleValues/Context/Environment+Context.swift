//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension EnvironmentValues {
    
    @Entry public var styleComponent: SnapStyle.Component = .init(type: .content, hierarchy: .primary)
    @Entry public var styleElement: SnapStyle.Element = .init(type: .content, hierarchy: .primary)

    public var styleContext: SnapStyle.Context {
        .init(component: styleComponent, element: styleElement)
    }

}
