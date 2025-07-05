//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(shape keyPath: SnapStyle.ShapeKey.ValueBuilderKeyPath) -> some View {
        modifier(ShapeModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

private struct ShapeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.ShapeKey.ValueBuilderKeyPath
    
    func body(content: Content) -> some View {
        // TODO: Remove Conditional
        if
            let shape = style.shape(for: keyPath)?.insettableShape(for: style)
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
