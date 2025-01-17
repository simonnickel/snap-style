//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleHStack<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let alignment: VerticalAlignment
    private let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath?
    private let content: () -> Content
    
    public init(
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        HStack(alignment: alignment, spacing: CGFloat(spacing(for: spacing))) {
            content()
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
