//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleVStack<Content>: View where Content : View {
    
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat? // TODO: Could be a Style Value
    private let content: () -> Content
    
    public init(alignment: HorizontalAlignment, spacing: CGFloat? = 0, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            content()
        }
    }
    
}
