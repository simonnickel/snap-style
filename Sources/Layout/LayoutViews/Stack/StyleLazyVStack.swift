//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLazyVStack<Content>: View where Content: View {

    @Environment(\.style) private var style

    private let alignment: HorizontalAlignment
    private let spacing: Style.Keys.NumberKey.ValueBuilderKeyPath?
    private let isStretching: Bool
    private let content: () -> Content

    public init(
        spacing: Style.Keys.NumberKey.ValueBuilderKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
        isStretching: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.isStretching = isStretching
        self.content = content
    }

    public var body: some View {
        contentStack
            .frame(maxWidth: isStretching ? .infinity : nil, alignment: Alignment(horizontal: alignment, vertical: .center))
    }

    @ViewBuilder
    private var contentStack: some View {
        let spacing = CGFloat(StyleStack<AnyView>.spacing(for: spacing, with: style))
        LazyVStack(alignment: alignment, spacing: spacing) {
            content()
        }
    }

}


// MARK: - Preview

#Preview {
    StyleLazyVStack {
        Text("Test 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}
