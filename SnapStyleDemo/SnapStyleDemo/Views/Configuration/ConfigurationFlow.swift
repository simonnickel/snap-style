//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

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
            .navigationTitle(rawValue.uppercased())
            .navigationBarTitleDisplayMode(.inline)
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
        .frame(width: 250, height: 400)
    }
}


// MARK: - Main List

struct ConfigurationListView: View {
    var body: some View {
        List {
            NavigationLink(value: ConfigurationFlow.Screen.color) {
                Label("Color", systemImage: "swatchpalette")
            }
        }
        .listStyle(.sidebar)
    }
}


// MARK: - Preview

#Preview {
    ConfigurationFlow()
}
