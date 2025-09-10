//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyle
import SwiftUI

struct FontDesignConfigurationRow: View {

    @Environment(\.style) private var style
    @Environment(\.demoConfiguration) private var demoConfiguration

    @State private var fontDesign: Font.Design? = Style.Context.fontDesignDefault

    var body: some View {
        // TODO: Whats the title?
        StyleListRow(.pick(Font.Design.allCases + [nil], titleKeyPath: \.debugDescription, selection: $fontDesign), icon: \.fontDesign) {
            StyleStack(spacing: \.spacingElements) {
                StyleLabel("Font Design")
            }
        }
        .onAppear {
            fontDesign = demoConfiguration.fontDesign
        }
        .onChange(of: fontDesign) { oldValue, newValue in
            demoConfiguration.fontDesign = newValue
        }
    }
}


// MARK: - Preview

#Preview {

    StyleList {
        FontDesignConfigurationRow()
    }

}
