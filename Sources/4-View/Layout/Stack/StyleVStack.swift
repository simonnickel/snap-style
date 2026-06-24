//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI


// MARK: - StyleVStack

public struct StyleVStack<Content>: View where Content: View {

    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: HorizontalAlignment
    private let width: FrameWidth
    private let content: () -> Content

    public init(
        _ spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
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
            axis: .vertical,
            spacing: spacing,
            alignment: Alignment(horizontal: alignment, vertical: .center),
            content: content,
        )
        .framed(width, alignment: Alignment(horizontal: alignment, vertical: .center))
    }

}


// MARK: - Preview

#Preview {
    StyleStackExample()
}
