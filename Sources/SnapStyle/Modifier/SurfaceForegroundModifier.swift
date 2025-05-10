//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    public func style(foreground keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(SurfaceForegroundModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct SurfaceForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if let surface = style.surface(for: keyPath) {
            content
                .foregroundStyle(surface)
        } else {
            content
        }
    }

}


// MARK: - Preview

#Preview {

    Text("Preview Example View")
        .style(foreground: \.accent)
    
}
