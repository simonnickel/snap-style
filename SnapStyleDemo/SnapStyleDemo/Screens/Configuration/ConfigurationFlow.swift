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
                    case .configuration: ConfigurationScreen()
                    case .color: ConfigurationColorScreen()
                }
            }
            .navigationTitle(rawValue.capitalized)
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
    }
    
    @State private var navigationState: [Screen] = []
    
    var body: some View {
        
        NavigationStack(path: $navigationState) {
            Screen.configuration.screen
                .navigationDestination(for: Screen.self) { screen in
                    screen.screen
                }
        }
        .environment(\.navigationStateConfiguration, navigationState)
        
    }
}

extension EnvironmentValues {
    @Entry var navigationStateConfiguration: [ConfigurationFlow.Screen] = []
}

// MARK: - Preview

#Preview {
    ConfigurationFlow()
}
