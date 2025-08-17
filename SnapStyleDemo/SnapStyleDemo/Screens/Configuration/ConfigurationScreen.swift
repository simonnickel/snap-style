//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationScreen: View {
    
    @Environment(\.navigationStateConfiguration) private var navigationState
    
    var body: some View {
        StyleList(insetTop: false) {
            let screen = ConfigurationFlow.Screen.color
            StyleListRow(
                .navigate(screen, isPresented: navigationState.contains(screen)),
                systemImage: "swatchpalette"
            ) {
                Text("Color")
            }

            ScaleFactorConfigurationRow()
            
            FontDesignConfigurationRow()
            
            FontWidthConfigurationRow()
            
            CornerRadiusConfigurationRow()
        }
    }
    
}


// MARK: - Preview

#Preview {
    NavigationStack {
        ConfigurationScreen()
    }
}
