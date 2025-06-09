//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationListView: View {
    
    @Environment(\.navigationStateConfiguration) private var navigationState
    
    var body: some View {
        StyleList(insetTop: false) {
            StyleListRow(
                .navigate(ConfigurationFlow.Screen.color),
                systemImage: "swatchpalette",
                isSelected: navigationState.contains(ConfigurationFlow.Screen.color)
            ) {
                Text("Color")
            }

            ScaleFactorConfigurationRow()
            
            FontDesignConfigurationRow()
        }
    }
    
}


// MARK: - Preview

#Preview {
    NavigationStack {
        ConfigurationListView()
    }
}
