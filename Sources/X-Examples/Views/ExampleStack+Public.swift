//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleView
import SwiftUI

/// Public wrapper for `SnapStyleView.StackExample`.
public struct ExampleStack: View {

    public init() {}

    public var body: some View {
        StackExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStack()
}
