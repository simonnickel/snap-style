//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLazyVStack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let alignment: HorizontalAlignment
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let fillsWidth: Bool
    private let content: () -> Content

    public init(
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.fillsWidth = fillsWidth
        self.content = content
    }

    public var body: some View {
        contentStack
            .frame(maxWidth: fillsWidth ? .infinity : nil, alignment: Alignment(horizontal: alignment, vertical: .center))
    }

    @ViewBuilder
    private var contentStack: some View {
        LazyVStack(alignment: alignment, spacing: resolvedSpacing) {
            content()
        }
    }

    private var resolvedSpacing: CGFloat {
        if let key = spacing ?? styleSpacing, let value = style.number(for: key) {
            CGFloat(value)
        } else { 0 }
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
