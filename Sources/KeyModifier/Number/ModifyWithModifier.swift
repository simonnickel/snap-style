//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    /// Convenience modifier to access a `Number` and use it in a closure to use as input for other modifiers.
    ///
    /// Supports animated change.
    ///
    /// - Parameters:
    ///   - valueKeyPath: The `Number` to access.
    ///   - transform: A closure with access to the resolved value and content to apply it on.
    public func styleModify(
        with valueKeyPath: Style.NumberKey.ValueBuilderKeyPath?,
        transform: @escaping (AnyView, Style.NumberKey.Value.WrappedValue?) -> some View
    ) -> some View {
        modifier(ValueModifier(keyPath: valueKeyPath, transform: transform))
    }

}


// MARK: - Modifier

private struct ValueModifier<Output: View>: ViewModifier {

    typealias Value = Style.NumberKey.Value.WrappedValue

    @Environment(\.style) private var style

    let keyPath: Style.NumberKey.ValueBuilderKeyPath?
    let transform: (AnyView, Value?) -> Output

    func body(content: Content) -> some View {
        let value: Value? = style.number(for: keyPath)
        transform(AnyView(content), value)
    }

}


// MARK: - Preview

#Preview {

    @Previewable @State var isFirst: Bool = true
    @Previewable @State var keyPath: Style.NumberKey.ValueBuilderKeyPath = \.spacingGroups

    VStack(spacing: 20) {
        Text("Some Text")

            .styleModify(with: keyPath) { content, value in
                content
                    .padding(.horizontal, value ?? .zero)
            }

            .padding(.vertical, 20)
            .background(.yellow)

        Button {
            withAnimation {
                isFirst.toggle()
                keyPath = isFirst ? \.spacingGroups : \.spacingSections
            }
        } label: {
            Text("Switch padding")
        }
    }

}
