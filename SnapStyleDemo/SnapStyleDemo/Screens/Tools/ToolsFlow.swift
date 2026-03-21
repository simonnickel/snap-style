//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleDebug
import SwiftUI

struct ToolsFlow: View {
    
    @Observable class NavigationState {
        var stack: [Screen] = []
    }

    @MainActor
    enum Screen: Hashable, Equatable {
        case root
        
        // Tools
        case components

        // Caches
        case cacheNumber
        case cacheFont
        case cacheSurface
        case cacheComposition

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .root: ToolsScreen(data: .tools)
                    
                    case .components: DebugComponentsScreen(components: [.base, .screen, .contentCard, .accentCard, .metricCard, .list, .listRow])

                    case .cacheNumber: DebugCacheScreen<Style.Attribute.Number>()
                    case .cacheFont: DebugCacheScreen<Style.Attribute.Font>()
                    case .cacheSurface: DebugCacheScreen<Style.Attribute.Surface>()
                    case .cacheComposition: DebugCacheScreen<Style.Attribute.Composition>()
                }
            }
            .navigationTitle(title)
        }
        
        var title: String {
            switch self {
                case .root: "Tools"

                case .components: "Components"

                case .cacheNumber: "Number"
                case .cacheFont: "Font"
                case .cacheSurface: "Surface"
                case .cacheComposition: "Composition"
            }
        }
    }

    let root: Screen
    @State private var navigationState: NavigationState = .init()

    var body: some View {
        
        NavigationStack(path: $navigationState.stack) {
            root.screen
                .navigationDestination(for: Screen.self) { screen in
                    screen.screen
                }
        }
        .environment(\.navigationStateTools, navigationState)
        
    }

}

extension EnvironmentValues {
    @Entry var navigationStateTools: ToolsFlow.NavigationState = .init()
}


// MARK: - Preview

#Preview {
    ToolsFlow(root: .root)
}
