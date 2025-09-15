//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyle
import SwiftUI

struct CornerRadiusConfigurationRow: View {

    @Environment(\.style) private var style
    @Environment(\.demoConfiguration) private var demoConfiguration

    @State private var option: DemoConfiguration.CornerRadiusOption = .medium

    var body: some View {
        StyleListRow(.pickInline(DemoConfiguration.CornerRadiusOption.allCases, titleKeyPath: \.rawValue, selection: $option), icon: \.configCornerRadius) {
            StyleStack(spacing: \.spacingElements) {
                StyleLabel("Corner Radius")
            }
        }
        .onAppear {
            option = demoConfiguration.cornerRadius
        }
        .onChange(of: option) { oldValue, newValue in
            demoConfiguration.cornerRadius = newValue
        }
    }
}


// MARK: - Preview

#Preview {

    StyleList {
        FontWidthConfigurationRow()
    }

}
