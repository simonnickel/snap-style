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
        StyleVStack(spacing: \.spacingElements, alignment: .center) {

            StyleHStack(alignment: .top) {
                topLeading()
                StyleSpacer(minLength: \.spacingElements)
                topTrailing()
            }

            StyleHStack(alignment: .bottom) {
                bottomLeading()
                StyleSpacer(minLength: \.spacingElements)
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
                },
                topTrailing: {
                    Text("Top Trailing")
                },
                bottomLeading: {
                    Text("Bottom Leading")
                },
                bottomTrailing: {
                    Text("Bottom Trailing")
                }
            )
            .background(.green)
        }
    }

    return VStack(spacing: 20) {
        PreviewCornerContainer()
            .fixedSize()
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
        PreviewCornerContainer()

    }
    .frame(maxWidth: .infinity)
    .background(.gray)
}
