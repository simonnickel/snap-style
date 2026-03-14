//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension Style.Views.Button {
    
    public enum Variant {
        
        case `default`
        case plain
        case primary
        case secondary
        case icon(hierarchy: Style.Component.Hierarchy = .primary)
        case component(Style.Component, hierarchy: Style.Element.Hierarchy = .primary)
        
        var component: Style.Component {
            switch self {
                case .plain: .base
                case .default, .primary: .button(.primary)
                case .secondary: .button(.secondary)
                case .icon(let hierarchy): .buttonIconOnly(hierarchy)
                case .component(let component, hierarchy: _): component
            }
        }
        
    }
    
}


// MARK: - Environment

extension EnvironmentValues {
    @Entry public var styleButtonVariant: Style.Views.Button.Variant = .default
}

extension View {
    public func style(buttonVariant: Style.Views.Button.Variant?) -> some View {
        environment(\.styleButtonVariant, buttonVariant ?? .default)
    }
}
