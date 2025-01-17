//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct DebugKeyRowNumber: View {
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    
    var body: some View {
        HStack {
            Text("\(keyPath)")
        }
    }
}

#Preview {
    DebugKeyRowNumber(keyPath: \.spacingSections)
}
