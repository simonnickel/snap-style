//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleView
import SwiftUI

/// Public wrapper for `SnapStyleView.StackVLazyExample`.
public struct ExampleStackVLazy: View {

    public init() {}

    public var body: some View {
        StackVLazyExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStackVLazy()
}
