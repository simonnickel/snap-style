//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI


// MARK: - StyleHStack

public struct StyleHStack<Content>: View where Content: View {

    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: VerticalAlignment
    private let width: FrameWidth
    private let content: () -> Content

    public init(
        _ spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        width: FrameWidth = .fill,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.width = width
        self.content = content
    }

    public var body: some View {
        StyleStack(
            axis: .horizontal,
            spacing: spacing,
            alignment: Alignment(horizontal: .leading, vertical: alignment),
            content: content,
        )
        .framed(width, alignment: Alignment(horizontal: .leading, vertical: alignment))
    }

}


// MARK: - Preview

#Preview {
    StyleStackExample()
}
