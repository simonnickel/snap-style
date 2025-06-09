//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationListView: View {
    
    var body: some View {
        StyleList(insetTop: false) {
            StyleListRow(.navigate(ConfigurationFlow.Screen.color), systemImage: "swatchpalette") {
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
