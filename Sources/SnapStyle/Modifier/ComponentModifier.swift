//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum Component {
        case screen, content, list, card

        public enum Hierarchy {

            case primary
            case secondary

        }
    }

}

internal struct ComponentModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let component: SnapStyle.Component

    func body(content: Content) -> some View {
        content
    }

}

extension View {

    public func style(component: SnapStyle.Component) -> some View {
        self.modifier(ComponentModifier(component: component))
    }

}
