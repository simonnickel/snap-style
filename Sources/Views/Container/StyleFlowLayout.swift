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

    private let spacingH: Style.Keys.Number.ValueBuilderKeyPath?
    private let spacingV: Style.Keys.Number.ValueBuilderKeyPath?

    public init(
        spacingH: Style.Keys.Number.ValueBuilderKeyPath? = nil,
        spacingV: Style.Keys.Number.ValueBuilderKeyPath? = nil
    ) {
        self.spacingH = spacingH
        self.spacingV = spacingV
    }
    
    private func getSpacingH() -> CGFloat {
        guard let value = style.number(for: spacingH) else { return 0 }

        return CGFloat(value)
    }

    private func getSpacingV() -> CGFloat {
        guard let value = style.number(for: spacingV) else { return 0 }

        return CGFloat(value)
    }
    
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let spacingH: CGFloat = getSpacingH()
        let spacingV: CGFloat = getSpacingV()
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
        let spacingH: CGFloat = getSpacingH()
        let spacingV: CGFloat = getSpacingV()
        let sizes = sizes(for: subviews)

        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0

        for index in subviews.indices {
            if lineX + sizes[index].width + spacingH > (proposal.width ?? 0) {
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

#Preview {
    
    @Previewable @State var isActive: Bool = true

    StyleFlowLayout(
        spacingH: isActive ? \.spacingSections : nil,
        spacingV: isActive ? \.spacingElements : nil
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
