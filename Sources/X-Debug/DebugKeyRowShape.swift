//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct DebugKeyRowShape: View {

    let keyPath: Style.Keys.Shape.ValueBuilderKeyPath

    var body: some View {
        HStack {
            Text("\(keyPath)")
        }
    }
}

#Preview {
    DebugKeyRowShape(keyPath: \.anyContainer)
}
