//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleLayout
import SnapStyleModifier
import SwiftUI

/// Public wrapper for `SnapStyleViews.CornerContainerExample`.
public struct ExampleStyleSurfaceBorderModifier: View {

    public init() {}

    public var body: some View {
        StyleScreen {
            StyleSurfaceBorderModifierExample()
        }
    }

}


// MARK: - Preview

#Preview {
    ExampleStyleSurfaceBorderModifier()
}
