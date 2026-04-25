//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleLayout
import SwiftUI

public struct CornerContainer<TopLeading: View, TopTrailing: View, BottomLeading: View, BottomTrailing: View>: View {

    private let topLeading: () -> TopLeading
    private let topTrailing: () -> TopTrailing
    private let bottomLeading: () -> BottomLeading
    private let bottomTrailing: () -> BottomTrailing

    public init(
        @ViewBuilder topLeading: @escaping () -> TopLeading,
        @ViewBuilder topTrailing: @escaping () -> TopTrailing,
        @ViewBuilder bottomLeading: @escaping () -> BottomLeading,
        @ViewBuilder bottomTrailing: @escaping () -> BottomTrailing
    ) {
        self.topLeading = topLeading
        self.topTrailing = topTrailing
        self.bottomLeading = bottomLeading
        self.bottomTrailing = bottomTrailing
    }

    public var body: some View {
        StyleStack(spacing: \.spacingElements, alignmentV: .center) {

            StyleStack(.horizontal, alignmentV: .top) {
                topLeading()
                StyleSpacer(min: \.spacingElements)
                topTrailing()
            }

            StyleStack(.horizontal, alignmentV: .bottom) {
                bottomLeading()
                StyleSpacer(min: \.spacingElements)
                bottomTrailing()
            }

        }
    }
}


// MARK: - Preview

#Preview {
    CornerContainerExample()
}

package struct CornerContainerExample: View {

    package init() {}

    package var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                cornerContainer
                cornerContainer
                    .frame(maxWidth: 90)
                cornerContainer
                    .frame(maxWidth: 100)
                cornerContainer
                    .frame(maxWidth: 110)
                cornerContainer
                    .frame(maxWidth: 200)
                cornerContainer
                    .frame(maxWidth: 300)
            }
            .frame(maxWidth: .infinity)
            .background(.gray)
        }
    }

    private var cornerContainer: some View {
        CornerContainer(
            topLeading: {
                Text("Top Leading")
                    .background(.yellow)
            },
            topTrailing: {
                Text("Top Trailing")
                    .background(.yellow)
            },
            bottomLeading: {
                Text("Bottom Leading")
                    .background(.yellow)
            },
            bottomTrailing: {
                Text("Bottom Trailing")
                    .background(.yellow)
            }
        )
        .background(.green)
    }
}
