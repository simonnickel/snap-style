//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyle
import SnapStyleBase
import SwiftUI

struct FontWidthConfigurationRow: View {

    @Environment(\.style) private var style
    @Environment(\.demoConfiguration) private var demoConfiguration

    @State private var fontWidth: Font.Width? = SnapStyle.Context.fontWidthDefault

    var body: some View {
        StyleListRow(.pick(Font.Width.allCases + [nil], selection: $fontWidth), icon: \.fontDesign) {
            StyleVStack(spacing: \.spacingElements) {
                StyleLabel("Font Width")
            }
        }
        .onAppear {
            fontWidth = demoConfiguration.fontWidth
        }
        .onChange(of: fontWidth) { oldValue, newValue in
            demoConfiguration.fontWidth = newValue
        }
    }
}


// MARK: - Preview

#Preview {

    StyleList {
        FontWidthConfigurationRow()
    }

}
