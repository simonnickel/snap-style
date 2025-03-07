//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleVStack<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let alignment: HorizontalAlignment
    private let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath?
    private let isStretching: Bool
    private let isLazy: Bool
    private let content: () -> Content
    
    public init(
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
        isStretching: Bool = true,
        isLazy: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.isStretching = isStretching
        self.isLazy = isLazy
        self.content = content
    }
    
    public var body: some View {
        if isStretching {
            contentStack
                .frame(maxWidth: .infinity, alignment: Alignment(horizontal: alignment, vertical: .center))
        } else {
            contentStack
        }
    }
    
    @ViewBuilder
    private var contentStack: some View {
        let spacing = CGFloat(spacing(for: spacing))
        if isLazy {
            LazyVStack(alignment: alignment, spacing: spacing) {
                content()
            }
        } else {
            VStack(alignment: alignment, spacing: spacing) {
                content()
            }
        }
    }
    
    private func spacing(for keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath?) -> SnapStyle.NumberKey.Value.WrappedValue {
        guard let keyPath else { return 0 }
        
        return switch style.value(for: keyPath, in: styleContext) {
            case .value(let value): value
            case .none: 0
        }
    }
    
}


// MARK: - Preview

#Preview {
    StyleVStack {
        Text("Test 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}

#Preview("Lazy") {
    StyleVStack(isLazy: true) {
        Text("Test Row 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}
