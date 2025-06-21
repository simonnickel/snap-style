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
    let insetVerticalEdges: Bool
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if
            let maxWidth = style.number(for: Constants.keyPathMaxWidth),
            let minInset = style.number(for: Constants.keyPathInset)
        {
            // The width available.
            let availableWidth = geometrySizeScreen.width
            // The available width for the content to fill.
            let widthForContent = applyReadableWidth ? min(availableWidth, maxWidth) : geometrySizeScreen.width
            // Margin to restrict to readable width.
            let marginWithoutInset = (geometrySizeScreen.width - widthForContent) / 2
            // Apply inset, if margin is not already large enough.
            let inset = insetHorizontalEdges ? max(marginWithoutInset, minInset) : marginWithoutInset

            let insetTop = insetVerticalEdges ? style.number(for: \.insetScreenTop) : nil
            let insetBottom = insetVerticalEdges ? style.number(for: \.insetScreenBottom) : nil

//            let _ = print("###")
//            let _ = print("geometrySizeScreen: \(geometrySizeScreen)")
//            let _ = print("geometrySafeAreaInsets: \(geometrySafeAreaInsets)")
//            let _ = print("availableWidth: \(availableWidth)")
//            let _ = print("widthForContent: \(widthForContent)")
//            let _ = print("marginWithoutInset: \(marginWithoutInset)")
//            let _ = print("inset: \(inset)")
            content()
                .environment(\.geometrySizeContent, CGSize(
                    width: geometrySizeScreen.width - (inset * 2),
                    height: geometrySizeScreen.height - geometrySafeAreaInsets.top - geometrySafeAreaInsets.bottom
                ))
                .safeAreaPadding(.init(top: insetTop ?? 0, leading: 0, bottom: insetBottom ?? 0, trailing: 0))
                .if(allowOverflow) { content in
                    // TODO FB18231015: Content outside of SafeAreaPadding not interactive
                    content
                        .safeAreaPadding(.init(horizontal: inset, vertical: 0))
                } else: { content in
                    content
                        .contentMargins(.leading, inset + geometrySafeAreaInsets.leading, for: .scrollContent)
                        .contentMargins(.trailing, inset + geometrySafeAreaInsets.trailing, for: .scrollContent)
                        .contentMargins(.vertical, 0, for: .scrollContent)
                }
        } else {
            content()
        }
    }
    
}
