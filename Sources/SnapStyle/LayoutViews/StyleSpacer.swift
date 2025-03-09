//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct StyleSpacer: View {
    
    @Environment(\.style) var style
    @Environment(\.styleContext) var styleContext
    
    let minLength: SnapStyle.NumberKey.ValueBuilderKeyPath
    
    var body: some View {
        let value = style.number(for: minLength, in: styleContext)
        Spacer(minLength: CGFloat(value ?? 0))
    }
    
}


// MARK: - Preview

#Preview {
    HStack {
        Rectangle()
        StyleSpacer(minLength: \.spacingElements)
        Rectangle()
    }
}
