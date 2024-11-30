//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct FontModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let fontKey: SnapStyle.FontKey
    
    func body(content: Content) -> some View {
        let font = style.font(for: fontKey, in: styleContext)
        content
            .font(font)
    }
    
}

extension View {
    
    public func font(_ key: SnapStyle.FontKey) -> some View {
        self.modifier(FontModifier(fontKey: key))
    }
    
}
