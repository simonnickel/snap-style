//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleDefinitions
import SwiftUI

extension View {

    /// Applies the `Surface` as `.background()`
    ///
    /// Supports animated change.
    ///
    /// - Parameter keyPath: The `Surface` to apply, `nil` will apply a clear background.
    /// - Parameter ignoresSafeAreaEdges: Controls the safe area behaviour.
    public func style(
        background keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath?,
        ignoresSafeAreaEdges: Edge.Set = []
    ) -> some View {
        modifier(SurfaceBackgroundModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
    }

}


// MARK: - Modifier

internal struct SurfaceBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        // Has to be applied even if no value is present, to allow animation of appearing value.
        /// The key`\.none` results in `nil`.
        /// If no background should be set, `.clear` is used.
        let surface = style.surface(for: keyPath ?? \.none)
        content
            .background(surface ?? AnyShapeStyle(.clear), ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}


// MARK: - Preview

#Preview {

    @Previewable @State var isAccent: Bool = false

    Text("Background: .accent")
        .padding()
        .style(background: \.accent)
    Text("Background: nil")
        .style(background: nil)

    VStack() {
        Text("toggled")
            .padding()
            .style(background: isAccent ? \.accentComplementary : nil)

        StyleButton {
            withAnimation {
                isAccent.toggle()
            }
        } content: {
            Text("Toggle Accent")
        }
    }
    .padding()
    .background(.yellow)

}
