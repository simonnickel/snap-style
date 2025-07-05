//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    /// Applies the `Number` as `.frame(maxWidth:)`
    ///
    /// Supports animated change.
    ///
    /// - Parameters:
    ///   - keyPath: The `Number` to apply as maxWidth, `nil` is the inert value
    ///   - alignment: The `Alignment` of this view inside the resulting frame. Note that most alignment values have no apparent effect when the size of the frame happens to match that of this view.
    public func style(
        maxWidth keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath?,
        alignment: Alignment = .leading
    ) -> some View {
        modifier(FrameMaxWidthModifier(keyPath: keyPath, alignment: alignment))
    }

}


// MARK: - Modifier

private struct FrameMaxWidthModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath?
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        let value = style.cgFloat(for: keyPath)
        content
            .frame(maxWidth: value, alignment: alignment)
    }
    
}


// MARK: - Preview

#Preview {

    @Previewable @State var isActive: Bool = true

    VStack {
        Text("Some Preview Content")
    }
    .style(maxWidth: isActive ? \.spacingSections : nil)
    .background(.green)

    StyleButton {
        withAnimation {
            isActive.toggle()
        }
    } content: {
        Text("Toggle")
    }

}
