//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyleBase
import SnapStyleLayout
import SwiftUI

/// An HStack that drops to a new line.
/// Inspired by: https://swiftwithmajid.com/2022/11/16/building-custom-layout-in-swiftui-basics/
public struct StyleFlowLayout: Layout {
    
    @Environment(\.style) private var style

    // Can not use Style.Keys.Number.ValueBuilderKeyPath because Environment is not available in Layout.
    private let spacingH: Style.Keys.Number.Value.WrappedValue?
    private let spacingV: Style.Keys.Number.Value.WrappedValue?

    public init(
        spacingH: Style.Keys.Number.Value.WrappedValue? = nil,
        spacingV: Style.Keys.Number.Value.WrappedValue? = nil
    ) {
        self.spacingH = spacingH
        self.spacingV = spacingV
    }
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let spacingH: CGFloat = spacingH ?? 0
        let spacingV: CGFloat = spacingV ?? 0
        let sizes = sizes(for: subviews)

        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0

        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0

        for index in sizes.indices {
            let size = sizes[index]
            let widthAndSpacing = size.width + (index > sizes.startIndex ? spacingH : 0)
            if lineWidth + widthAndSpacing > proposal.width ?? 0 {
                totalHeight += lineHeight + spacingV
                lineWidth = size.width
                lineHeight = size.height
            } else {
                lineWidth += widthAndSpacing
                lineHeight = max(lineHeight, size.height)
            }

            totalWidth = max(totalWidth, lineWidth)
        }

        totalHeight += lineHeight

        return .init(width: totalWidth, height: totalHeight)
    }

    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let spacingH: CGFloat = spacingH ?? 0
        let spacingV: CGFloat = spacingV ?? 0
        let sizes = sizes(for: subviews)

        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0

        for index in subviews.indices {
            if lineX + sizes[index].width + spacingH > (proposal.width ?? 0) + bounds.minX {
                lineY += lineHeight + spacingV
                lineHeight = 0
                lineX = bounds.minX
            } else if index > subviews.startIndex {
                lineX += spacingH
            }

            subviews[index].place(
                at: .init(
                    x: lineX,
                    y: lineY
                ),
                anchor: .topLeading,
                proposal: ProposedViewSize(sizes[index])
            )

            lineHeight = max(lineHeight, sizes[index].height)
            lineX += sizes[index].width
        }
    }
    
    private func sizes(for subviews: Subviews) -> [CGSize] {
        return subviews.map { $0.sizeThatFits(.unspecified) }
    }
}


// MARK: - Preview

#Preview("Text") {

    @Previewable @State var isActive: Bool = true
    
    @ScaledNumber(\.spacingSections) var spacingH
    @ScaledNumber(\.spacingElements) var spacingV

    StyleFlowLayout(
        spacingH: spacingH,
        spacingV: spacingV
    ) {
        ForEach(0..<7) { _ in
            Group {
                Text("Hello")
                    .font(.largeTitle)
                Text("World")
                    .font(.title)
                Text("1!2")
                    .font(.title)
            }
            .border(Color.red)
        }
    }
    .background(.orange)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.yellow)
    
    StyleButton {
        withAnimation(.smooth) {
            isActive.toggle()
        }
    } content: {
        Text("Toggle Spacing")
    }
}

#Preview("Circles") {

    @Previewable @State var isActive: Bool = true
    
    @ScaledNumber(\.spacingElements) var spacingH
    @ScaledNumber(\.spacingElements) var spacingV
    
    StyleFlowLayout(
        spacingH: spacingH,
        spacingV: spacingV
    ) {
        ForEach(0..<7) { _ in
            Group {
                Circle()
                    .frame(width: 50, height: 50)
                Circle()
                    .frame(width: 50, height: 50)
                Circle()
                    .frame(width: 50, height: 50)
                Circle()
                    .frame(width: 50, height: 50)
            }
        }
    }

    StyleButton {
        withAnimation(.smooth) {
            isActive.toggle()
        }
    } content: {
        Text("Toggle Spacing")
    }
}

#Preview("In StyleListRow") {

    @Previewable @State var isActive: Bool = true
    
    @ScaledNumber(\.spacingElements) var spacingH
    @ScaledNumber(\.spacingElements) var spacingV
    
    NavigationStack {
        StyleList {
            Section {
                StyleListRow(
                    .plain,
                    icon: \.favorite
                ) {} content: {
                    VStack(alignment: .leading, spacing: 0) {
                        StyleFlowLayout(
                            spacingH: spacingH,
                            spacingV: spacingV
                        ) {
                            ForEach(0..<7) { _ in
                                Group {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                    Circle()
                                        .frame(width: 50, height: 50)
                                    Circle()
                                        .frame(width: 50, height: 50)
                                    Circle()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    StyleButton {
        withAnimation(.smooth) {
            isActive.toggle()
        }
    } content: {
        Text("Toggle Spacing")
    }
}
