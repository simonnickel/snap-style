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
    private let spacing: SnapStyle.NumberKey.ValueKeyPath?
    private let content: () -> Content
    
    public init(
        spacing: SnapStyle.NumberKey.ValueKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: alignment, spacing: CGFloat(spacing(for: spacing))) {
            content()
        }
    }
    
    private func spacing(for keyPath: SnapStyle.NumberKey.ValueKeyPath?) -> SnapStyle.NumberKey.Value.WrappedValue {
        // TODO: Wrapped Value for keypath
        guard let keyPath else { return 0 }
        return switch style.value(for: keyPath, in: styleContext) {
            case .definition(let value): value
            case .reference(let keyPathReference): spacing(for: keyPathReference)
            case .none: 0
        }
    }
    
}
