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

    @State private var fontWidth: Font.Width = Style.Context.fontWidthDefault

    var body: some View {
        StyleListRow(.pick(Font.Width.allCases, titleKeyPath: \.description, selection: $fontWidth), icon: \.fontDesign) {
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
