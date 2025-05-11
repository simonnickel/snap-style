//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct ReadableContentContainer<ReadableContent: View>: View {
    
    private struct Constants {
        static var keyPathMaxWidthContent: SnapStyle.NumberKey.ValueBuilderKeyPath { \.widthReadableContent }
        static var keyPathInset: SnapStyle.NumberKey.ValueBuilderKeyPath { \.insetScreenHorizontal }
    }
    
    @Environment(\.style) private var style
    @Environment(\.screenGeometrySize) private var screenGeometrySize
    
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if
            let maxWidth = style.number(for: Constants.keyPathMaxWidthContent),
            let inset = style.number(for: Constants.keyPathInset)
        {
            StyleVStack(spacing: \.spacingSections) {
                content()
            }
            .if(allowOverflow) { content in
                // TODO: Why is this different?
                content
                    .safeAreaPadding(.init(horizontal: (screenGeometrySize.width - maxWidth) / 2, vertical: 0))
            } else: { content in
                let widthContent = min(maxWidth, screenGeometrySize.width) - (inset * 2)
                let value = (screenGeometrySize.width - widthContent) / 2
                return content
                    .contentMargins(.horizontal, value, for: .scrollContent)
            }
        } else {
            content()
        }
    }
    
}
