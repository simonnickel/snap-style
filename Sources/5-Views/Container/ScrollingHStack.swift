//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleView
import SwiftUI

public struct ScrollingHStack<Content: View>: View {

    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView(.horizontal) {
            Stack.HLazy(spacing: \.spacingElements) {
                content()
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
}


// MARK: - Preview

#Preview {
    ScrollingHStackExample()
}


package struct ScrollingHStackExample: View {

    package init() {}
    
    package var body: some View {
        ScrollingHStack {
            ForEach(0..<10, id: \.self) { _ in
                Text("Hello, World!")
                    .background(.yellow)
            }
        }
    }
}
