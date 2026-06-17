//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleView
import SwiftUI

/// Public wrapper for `SnapStyleView.ExampleStyleLazyHStack`.
public struct ExampleStyleLazyHStack: View {

    public init() {}

    public var body: some View {
        StyleLazyHStackExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStyleLazyHStack()
}
