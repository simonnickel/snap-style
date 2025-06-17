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
            StyleListRow(
                .navigate(ConfigurationFlow.Screen.color, isPresented: { screen in
                    navigationState.contains(screen)
                }),
                systemImage: "swatchpalette"
            ) {
                Text("Color")
            }

            ScaleFactorConfigurationRow()
            
            FontDesignConfigurationRow()
            
            FontWidthConfigurationRow()
        }
    }
    
}


// MARK: - Preview

#Preview {
    NavigationStack {
        ConfigurationScreen()
    }
}
