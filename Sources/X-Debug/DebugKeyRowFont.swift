//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct DebugKeyRowFont: View {

    let keyPath: Style.Attribute.Font.ValueBuilderKeyPath

    var body: some View {
        HStack {
            Text("\(keyPath.debugDescription)")
                .style(font: keyPath)
        }
    }
}

#Preview {
    DebugKeyRowFont(keyPath: \.content)
}
