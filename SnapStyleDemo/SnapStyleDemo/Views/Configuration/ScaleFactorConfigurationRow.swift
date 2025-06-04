//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ScaleFactorConfigurationRow: View {

    @Environment(\.style) private var style
    @Environment(\.configuration) private var configuration

    @State private var scaleFactor: CGFloat = 1.0

    var body: some View {
        StyleListRow(icon: \.scaleFactor) {
            StyleVStack(spacing: \.spacingElements) {
                StyleLabel("Scale Factor")
            }
        } content: {
            Slider(value: $scaleFactor, in: 0.5...2)
                .onAppear {
                    scaleFactor = configuration.scaleFactor
                }
                .onChange(of: scaleFactor) { oldValue, newValue in
                    configuration.scaleFactor = newValue
                }
        }
    }
}


// MARK: - Preview

#Preview {

    StyleList {
        ScaleFactorConfigurationRow()
    }

}
