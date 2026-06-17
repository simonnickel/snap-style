//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleView
import SwiftUI

/// Public wrapper for `SnapStyleView.StackHLazyExample`.
public struct ExampleStackHLazy: View {

    public init() {}

    public var body: some View {
        StackHLazyExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStackHLazy()
}
