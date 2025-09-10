//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLazyHStack<Content>: View where Content: View {

    @Environment(\.style) private var style

    private let alignment: VerticalAlignment
    private let spacing: Style.Keys.NumberKey.ValueBuilderKeyPath?
    private let content: () -> Content

    public init(
        spacing: Style.Keys.NumberKey.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        let spacing = CGFloat(spacing(for: spacing))
        LazyHStack(alignment: alignment, spacing: spacing) {
            content()
        }
    }

    private func spacing(for keyPath: Style.Keys.NumberKey.ValueBuilderKeyPath?) -> Style.Keys.NumberKey.Value.WrappedValue {
        guard let keyPath else { return 0 }

        return style.number(for: keyPath) ?? 0
    }

}


// MARK: - Preview

#Preview("Lazy") {
    StyleLazyHStack {
        Text("Test Row 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}
