//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    /// Applies the `Surface` as `.foregroundStyle()`
    ///
    /// Supports animated change.
    ///
    /// - Parameter keyPath: The `Surface` to apply, `nil` will use the environments value.
    public func style(
        foreground keyPath: Style.Attribute.Surface.ValueBuilderKeyPath?
    ) -> some View {
        modifier(SurfaceForegroundModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

private struct SurfaceForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Surface.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        // Has to be applied even if no value is present, to allow animation of appearing value.
        /// The key `\.none` results in `nil`.
        /// `.primary` is used to apply no specific value and use the environment's `foregroundStyle`.
        let surface = style.surface(for: keyPath ?? \.none)
        content
            .foregroundStyle(surface?.anyShapeStyle ?? AnyShapeStyle(.primary))
    }

}


// MARK: - Preview

#Preview {

    StyleSurfaceForegroundModifierExample()

}

package struct StyleSurfaceForegroundModifierExample: View {

    @State private var isAccent: Bool = false

    package init() {}

    package var body: some View {
        Text("Foreground: .accent")
            .style(foreground: \.accent)
        Text("Foreground: nil")
            .style(foreground: nil)

        VStack() {
            Text("Foreground: toggled")
                .style(foreground: isAccent ? \.accent : nil)
            Text("Foreground from Environment")
                .style(foreground: nil)

            Button {
                withAnimation {
                    isAccent.toggle()
                }
            } label: {
                Text("Toggle Accent")
            }
        }
        .style(foreground: \.onAccent)
        .padding()
        .background(.mint)
    }
}
