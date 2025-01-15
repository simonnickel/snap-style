//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleHStack<Content>: View where Content : View {
    
    private let alignment: VerticalAlignment
    private let spacing: CGFloat? // TODO: Should be a Style Value
    private let content: () -> Content
    
    public init(
        spacing: CGFloat? = 0,
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            content()
        }
    }
    
}
