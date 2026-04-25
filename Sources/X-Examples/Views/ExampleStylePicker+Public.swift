//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleLayout
import SwiftUI

/// Public wrapper for `StylePickerExample`.
public struct ExampleStylePicker: View {

    public init() {}

    public var body: some View {
        StylePickerExample()
    }

}


// MARK: - Preview

#Preview {
    ExampleStylePicker()
}
