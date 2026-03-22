//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleModifier
import SwiftUI

/// Public wrapper for `SnapStyleViews.CornerContainerExample`.
public struct ExampleStyleSurfaceBackgroundModifier: View {

    public init() {}

    public var body: some View {
        StyleSurfaceBackgroundModifierExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStyleSurfaceBackgroundModifier()
}
