//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension EnvironmentValues {
    
    @Entry public var style: SnapStyle = SnapStyle.defaults
    
    @Entry public var styleComponent: SnapStyle.Component = .init(type: .content, hierarchy: .primary)
    @Entry public var styleItem: SnapStyle.Item = .init(type: .content, hierarchy: .primary)

    public var styleContext: SnapStyle.Context {
        .init(component: styleComponent, item: styleItem)
    }

}
