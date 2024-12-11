//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

extension View {

//    public func style(font key: SnapStyle.FontKey, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
//        self
//            .modifier(FontModifier(key: key, hierarchy: hierarchy))
//    }

}


// MARK: - Modifier

//internal struct FontModifier: ViewModifier {
//    
//    @Environment(\.style) private var style
//    @Environment(\.styleComponent) private var styleComponent
//
//    let key: SnapStyle.FontKey
//    let hierarchy: SnapStyle.Item.Hierarchy
//
//    func body(content: Content) -> some View {
//        let value = style.font(for: key, in: SnapStyle.Context(component: styleComponent, hierarchy: hierarchy))
//        content
//            .font(value)
//    }
//    
//}

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
