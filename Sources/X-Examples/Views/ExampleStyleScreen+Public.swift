//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleLayout
import SwiftUI

/// Public wrapper for `SnapStyleLayout.StyleScreenExample`.
public struct ExampleStyleScreen: View {

    public init() {}

    public var body: some View {
        StyleScreenExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStyleScreen()
}
