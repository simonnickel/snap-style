//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct ReadableContentContainer<ReadableContent: View>: View {
    
    private struct Constants {
        static var keyPathMaxWidthContent: SnapStyle.NumberKey.ValueBuilderKeyPath { \.widthReadableContent }
    }
    
    @Environment(\.style) private var style
    @Environment(\.screenGeometrySize) private var screenGeometrySize
    
    let allowOverflow: Bool
    let content: () -> ReadableContent
    
    var body: some View {
        if let maxWidth = style.number(for: Constants.keyPathMaxWidthContent) {
            StyleVStack(spacing: \.spacingSections) {
                content()
            }
            .if(allowOverflow) { content in
                content
                    .safeAreaPadding(.init(horizontal: (screenGeometrySize.width - maxWidth) / 2, vertical: 0))
            } else: { content in
                content
                    .contentMargins(.horizontal, (screenGeometrySize.width - maxWidth) / 2, for: .scrollContent)
            }
        } else {
            content()
        }
    }
    
}
