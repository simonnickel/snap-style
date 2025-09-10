//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct DebugKeyRowComposition: View {

    let keyPath: Style.CompositionKey.ValueBuilderKeyPath

    var body: some View {
        Text("\(keyPath)")
            .style(composition: keyPath)
    }
}

#Preview {
    DebugKeyRowComposition(keyPath: \.contentContainer)
}
