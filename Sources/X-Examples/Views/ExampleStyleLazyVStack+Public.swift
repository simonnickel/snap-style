//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleView
import SwiftUI

/// Public wrapper for `SnapStyleView.ExampleStyleLazyVStack`.
public struct ExampleStyleLazyVStack: View {

    public init() {}

    public var body: some View {
        StyleLazyVStackExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStyleLazyVStack()
}
