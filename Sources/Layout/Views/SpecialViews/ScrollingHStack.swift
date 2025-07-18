//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct ScrollingHStack<Content: View>: View {

    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView(.horizontal) {
            StyleLazyHStack(spacing: \.spacingElements) {
                content()
            }
            .fixedSize(horizontal: false, vertical: true)
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
}


// MARK: - Preview

#Preview {
    ScrollingHStack {
        ForEach(0..<10, id: \.self) { _ in
            Text("Hello, World!")
                .background(.yellow)
        }
    }
}
