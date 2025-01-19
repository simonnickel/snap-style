//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct DebugKeyRowColor: View {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath
    
    var body: some View {
        let color = style.color(for: keyPath, in: styleContext)
        Text("\(keyPath)")
            .foregroundStyle(color ?? .white)
    }
}

#Preview {
    DebugKeyRowColor(keyPath: \.content0)
}
