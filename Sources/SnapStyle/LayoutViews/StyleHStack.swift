//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleHStack<Content>: View where Content : View {
    
    @Environment(\.styleDefinition) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let alignment: VerticalAlignment
    private let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath?
    private let isLazy: Bool
    private let content: () -> Content
    
    public init(
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        isLazy: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.isLazy = isLazy
        self.content = content
    }
    
    public var body: some View {
        let spacing = CGFloat(spacing(for: spacing))
        if isLazy {
            LazyHStack(alignment: alignment, spacing: spacing) {
                content()
            }
        } else {
            HStack(alignment: alignment, spacing: spacing) {
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
    StyleHStack {
        Text("Test 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}

#Preview("Lazy") {
    StyleHStack(isLazy: true) {
        Text("Test Row 1")
            .background(.green)
        Text("Test Row 2")
            .background(.mint)
    }
    .background(.yellow)
}
