//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyle
import SwiftUI

struct FontWidthConfigurationRow: View {

    @Environment(\.style) private var style
    @Environment(\.demoConfiguration) private var demoConfiguration

    @State private var fontWidth: Font.Width? = Style.Context.fontWidthDefault

    var body: some View {
        // TODO: Whats the title?
        StyleListRow(.pick(Font.Width.allCases + [nil], titleKeyPath: \.debugDescription, selection: $fontWidth), icon: \.fontDesign) {
            StyleStack(spacing: \.spacingElements) {
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
