//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLazyHStack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let alignment: VerticalAlignment
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let content: () -> Content

    public init(
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        LazyHStack(alignment: alignment, spacing: resolvedSpacing) {
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

#Preview("Lazy") {
    StyleLazyHStack {
        Text("Test Row 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}
