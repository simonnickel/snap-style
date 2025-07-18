//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

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
    struct PreviewCornerContainer: View {
        var body: some View {
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

    return ScrollView {
        VStack(spacing: 20) {
            PreviewCornerContainer()
            PreviewCornerContainer()
                .frame(maxWidth: 90)
            PreviewCornerContainer()
                .frame(maxWidth: 100)
            PreviewCornerContainer()
                .frame(maxWidth: 110)
            PreviewCornerContainer()
                .frame(maxWidth: 200)
            PreviewCornerContainer()
                .frame(maxWidth: 300)
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
    }
}
