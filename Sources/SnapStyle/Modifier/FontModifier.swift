//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(font keyPath: SnapStyle.FontKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(FontModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct FontModifier: ViewModifier {
    
    @Environment(\.styleDefinition) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.FontKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        let value = style.font(for: keyPath, in: styleContext)
        content
            .font(value)
    }
    
}
