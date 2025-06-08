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
    @Environment(\.geometrySafeAreaInsets) private var geometrySafeAreaInsets
    
    let insetHorizontalEdges: Bool
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if
            let maxWidth = style.number(for: Constants.keyPathMaxWidth),
            let minInset = style.number(for: Constants.keyPathInset)
        {
            // All insets have to be based on the safe area.
            let availableWidth = geometrySizeScreen.width - geometrySafeAreaInsets.leading - geometrySafeAreaInsets.trailing
            // The available width for the content to fill.
            let widthForContent = applyReadableWidth ? min(availableWidth, maxWidth) : geometrySizeScreen.width
            // Margin to restrict to readable width.
            let marginWithoutInset = (geometrySizeScreen.width - widthForContent) / 2
            // Apply inset, if margin is not already large enough.
            let inset = insetHorizontalEdges ? max(marginWithoutInset, minInset) : marginWithoutInset
            
            content()
                //.debugOverlay(info: "Inset: \(inset)")
                .environment(\.geometrySizeContent, CGSize(
                    width: geometrySizeScreen.width - (inset * 2),
                    height: geometrySizeScreen.height - geometrySafeAreaInsets.top - geometrySafeAreaInsets.bottom
                ))
                .if(allowOverflow) { content in
                    content
                        .safeAreaPadding(.init(horizontal: inset, vertical: 0))
                } else: { content in
                    content
                        .contentMargins(.horizontal, inset, for: .scrollContent)
                        .contentMargins(.vertical, 0, for: .scrollContent)
                }
        } else {
            content()
        }
    }
    
}
