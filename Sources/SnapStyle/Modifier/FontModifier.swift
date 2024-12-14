//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

extension View {

    public func style(font keyPath: SnapStyle.FontKey.ValueKeyPath) -> some View {
        self
            .modifier(FontModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct FontModifier: ViewModifier {
    
    @Environment(\.style) private var style

    let keyPath: SnapStyle.FontKey.ValueKeyPath

    func body(content: Content) -> some View {
        let value = style.font(for: keyPath, in: .any) // TODO: .any? or base?
        content
            .font(value)
    }
    
}


// MARK: - FromEnvironmentModifier

internal struct FontFromEnvironmentModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    func body(content: Content) -> some View {
        let keyPath = SnapStyle.FontKey.keyPath(for: styleContext.item.type)
        let value = style.font(for: keyPath, in: styleContext)
        content
            .font(value)
    }

}
