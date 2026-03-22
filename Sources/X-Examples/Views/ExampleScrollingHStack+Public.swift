//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


import SnapStyleBase
import SnapStyleViews
import SwiftUI

/// Public wrapper for `SnapStyleLayout.ExampleStyleStack`.
public struct ExampleScrollingHStack: View {
    
    public init() {}

    public var body: some View {
        ScrollingHStackExample()
    }
    
}


// MARK: - Preview

#Preview {
    ExampleScrollingHStack()
}
