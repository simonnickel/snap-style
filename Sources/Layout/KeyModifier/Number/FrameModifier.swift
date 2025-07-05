//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(
        maxWidth keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath,
        alignment: HorizontalAlignment = .leading
    ) -> some View {
        modifier(FrameMaxWidthModifier(keyPath: keyPath, alignment: alignment))
    }

}


// MARK: - Modifier

private struct FrameMaxWidthModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    let alignment: HorizontalAlignment
    
    func body(content: Content) -> some View {
        if
            let value = style.number(for: keyPath)
        {
            content
                .frame(maxWidth: value, alignment: Alignment(horizontal: alignment, vertical: .center))
        } else {
            content
        }
    }
    
}


// MARK: - Preview

#Preview {
    VStack {
        Text("Test")
    }
    .style(maxWidth: \.widthReadableContent)
    .background(.green)
}
