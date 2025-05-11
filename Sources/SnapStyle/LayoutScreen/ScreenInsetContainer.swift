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
    @Environment(\.geometrySizeScreen) private var geometrySizeScreen
    
    let insetHorizontalEdges: Bool
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if
            let maxWidth = style.number(for: Constants.keyPathMaxWidth),
            let minInset = style.number(for: Constants.keyPathInset)
        {
            // The available width for the content to fill.
            let widthForContent = applyReadableWidth ? min(maxWidth, geometrySizeScreen.width) : geometrySizeScreen.width
            // Margin to restrict to readable width.
            let marginWithoutInset = (geometrySizeScreen.width - widthForContent) / 2
            // Apply inset, if margin is not already large enough.
            let inset = insetHorizontalEdges ? max(marginWithoutInset, minInset) : marginWithoutInset
            
            content()
                .environment(\.geometryWidthContent, geometrySizeScreen.width - (inset * 2))
                .if(allowOverflow) { content in
                    content
                        .safeAreaPadding(.init(horizontal: inset, vertical: 0))
                } else: { content in
                    content
                        .contentMargins(.horizontal, inset, for: .scrollContent)
                }
        } else {
            content()
        }
    }
    
}
