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
        case icon(hierarchy: Style.Element.Hierarchy = .primary)
        case component(Style.ComponentDefinition, hierarchy: Style.Element.Hierarchy = .primary)
        
        var component: Style.ComponentDefinition {
            switch self {
                case .plain: .base
                case .default, .primary, .secondary: .button
                case .icon: .buttonIconOnly
                case .component(let component, hierarchy: _): component
            }
        }
        
        var hierarchy: Style.Element.Hierarchy? {
            switch self {
                case .plain: nil
                case .default, .primary: .primary
                case .secondary: .secondary
                case .icon(let hierarchy): hierarchy
                case .component(_, hierarchy: let hierarchy): hierarchy
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
