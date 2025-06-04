//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationFlow: View {
    
    @MainActor
    enum Screen: String {
        case configuration
        
        case color
        
        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .configuration: ConfigurationListView()
                    case .color: ColorSelectionScreen()
                }
            }
            .navigationTitle(rawValue.capitalized)
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
    }
    
    @State private var navigationPath: [Screen] = []
    
    var body: some View {
        NavigationStack {
            Screen.configuration.screen
                .navigationDestination(for: Screen.self) { screen in
                    screen.screen
                }
        }
    }
}


// MARK: - Main List

struct ConfigurationListView: View {
    var body: some View {
        StyleList {
            StyleListRow(.navigate(ConfigurationFlow.Screen.color), systemImage: "swatchpalette") {
                Text("Color")
            }

            StyleListRow(icon: \.scaleFactor) {
                ScaleFactorConfigurationRow()
            }
        }
    }
}


// MARK: - Preview

#Preview {
    ConfigurationFlow()
}
