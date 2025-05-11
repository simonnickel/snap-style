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
    
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if
            let maxWidth = style.number(for: Constants.keyPathMaxWidth),
            let inset = style.number(for: Constants.keyPathInset)
        {
            let width = applyReadableWidth ? min(maxWidth, screenGeometrySize.width) : screenGeometrySize.width
            let widthInset = width - (inset * 2)
            let value = (screenGeometrySize.width - widthInset) / 2
            
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
