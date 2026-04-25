//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleLayout
import SwiftUI

/// Public wrapper for `SnapStyleLayout.ExampleStyleStack`.
public struct ExampleStyleStack: View {
    
    public init() {}

    public var body: some View {
        StyleStackExample()
    }
    
}


// MARK: - Preview

#Preview {
    ExampleStyleStack()
}
