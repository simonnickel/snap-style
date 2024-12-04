//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum Component: Sendable, CaseIterable {
        case screen, content, list, card

        public enum Hierarchy {

            case primary
            case secondary

        }
    }

}

internal struct ComponentModifier: ViewModifier {

    @Environment(\.style) private var style

    let component: SnapStyle.Component

    func body(content: Content) -> some View {
        content
            .environment(\.styleComponent, component)
    }

}

extension View {

    public func style(component: SnapStyle.Component) -> some View {
        self.modifier(ComponentModifier(component: component))
    }

}
