//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct ScreenInsetContainer<ReadableContent: View>: View {
    
    private struct Constants {
        static var keyPathMaxWidth: SnapStyle.NumberKey.ValueBuilderKeyPath { \.widthReadableContent }
        static var keyPathInset: SnapStyle.NumberKey.ValueBuilderKeyPath { \.insetScreenHorizontal }
    }
    
    @Environment(\.style) private var style
    @Environment(\.screenGeometrySize) private var screenGeometrySize
    
    let insetHorizontalEdges: Bool
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if
            let maxWidth = style.number(for: Constants.keyPathMaxWidth),
            let inset = style.number(for: Constants.keyPathInset)
        {
            // The available width for the content to fill.
            let widthForContent = applyReadableWidth ? min(maxWidth, screenGeometrySize.width) : screenGeometrySize.width
            // Margin to restrict to readable width.
            let marginWithoutInset = (screenGeometrySize.width - widthForContent) / 2
            // Apply inset, if margin is not already large enough.
            let value = insetHorizontalEdges ? max(marginWithoutInset, inset) : marginWithoutInset
            
            StyleVStack(spacing: \.spacingSections) {
                content()
            }
            .if(allowOverflow) { content in
                content
                    .safeAreaPadding(.init(horizontal: value, vertical: 0))
            } else: { content in
                content
                    .contentMargins(.horizontal, value, for: .scrollContent)
            }
        } else {
            content()
        }
    }
    
}
