//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func styleModify(
        with valueKeyPath: SnapStyle.NumberKey.ValueBuilderKeyPath,
        transform: @escaping (AnyView, SnapStyle.NumberKey.Value.WrappedValue) -> some View
    ) -> some View {
        self.modifier(ValueModifier(keyPath: valueKeyPath, transform: transform))
    }

}


// MARK: - Modifier

internal struct ValueModifier<Output: View>: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    let transform: (AnyView, SnapStyle.NumberKey.Value.WrappedValue) -> Output

    func body(content: Content) -> some View {
        if let value = style.number(for: keyPath) {
            transform(AnyView(content), value)
        } else {
            content
        }
    }

}


// MARK: - Preview

#Preview {

    @Previewable @State var isFirst: Bool = true
    @Previewable @State var keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingGroups

    VStack(spacing: 20) {
        Text("Some Text")

            .styleModify(with: keyPath) { content, value in
                content
                    .padding(.horizontal, value)
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
