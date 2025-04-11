//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(shape keyPath: SnapStyle.ShapeKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(ShapeModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct ShapeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let keyPath: SnapStyle.ShapeKey.ValueBuilderKeyPath
    
    func body(content: Content) -> some View {
        if
            let shape = style.shape(for: keyPath, in: styleContext)?.insettableShape(for: style, in: styleContext)
        {
            content
#if !os(macOS)
                .contentShape(.hoverEffect, shape)
#endif
                .containerShape(shape)
        } else {
            content
        }
    }
    
}
