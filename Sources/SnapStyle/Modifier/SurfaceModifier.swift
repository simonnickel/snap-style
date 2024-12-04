//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func style(surface key: SnapStyle.SurfaceKey, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self
            .modifier(ForegroundModifier(key: key, hierarchy: hierarchy))
            .modifier(BackgroundModifier(key: key, hierarchy: hierarchy))
    }

}


// MARK: - Modifier

internal struct ForegroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleComponent) private var styleComponent

    let key: SnapStyle.SurfaceKey
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        if let foreground = style.surface(layer: .foreground, for: key, in: SnapStyle.Context(component: styleComponent, hierarchy: hierarchy)) {
            content
                .foregroundStyle(foreground)
        } else {
            content
        }
    }
    
}

internal struct BackgroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleComponent) private var styleComponent

    let key: SnapStyle.SurfaceKey
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        if let background = style.surface(layer: .background, for: key, in: SnapStyle.Context(component: styleComponent, hierarchy: hierarchy)) {
            content
                .background(background)
        } else {
            content
        }
    }

}
