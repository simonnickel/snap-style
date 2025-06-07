//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct DebugKeyRowSurface: View {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    var body: some View {
        let surface = style.surface(for: keyPath)
        Text("\(keyPath)")
            .foregroundStyle(surface ?? AnyShapeStyle(.white))
    }
}

#Preview {
    DebugKeyRowSurface(keyPath: \.content0)
}
