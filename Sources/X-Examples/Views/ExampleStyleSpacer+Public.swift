//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleLayout
import SwiftUI

/// Public wrapper for `SnapStyleLayout.StyleSpacerExample`.
public struct ExampleStyleSpacer: View {

    public init() {}

    public var body: some View {
        StyleSpacerExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStyleSpacer()
}
