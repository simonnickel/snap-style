//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleDebug
import SwiftUI

struct ContentFlow: View {
    
    @Observable class NavigationState {
        var stack: [Screen] = []
    }

    @MainActor
    enum Screen: Hashable, Equatable {
        case rootExamples
        case rootTools
        
        /// A generic destination to navigate to.
        case destination(String, source: String)

        // Examples
        case structured
        case componentStack

        // Components
        case card
        case list
        case action

        // Tools
        case elements

        // Caches
        case cacheNumber
        case cacheFont
        case cacheSurface
        case cacheComposition

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .rootExamples: ContentListScreen(data: .examples)
                    case .rootTools: ContentListScreen(data: .tools)
                        
                    case .destination(let title, source: let source):
                        ComponentListScreen(title: title, source: source)

                    // Examples
                    case .structured: StructuredScreen()
                    case .componentStack: ComponentStackScreen()

                    // Components
                    case .card: ComponentCardScreen()
                    case .list: ComponentListScreen(title: self.title, source: "")
                    case .action: ComponentActionScreen()

                    case .elements: DebugElementScreen(components: [.screen, .contentCard, .accentCard, .metricCard, .list, .listRow])

                    case .cacheNumber: DebugCacheScreen<Style.NumberKey>()
                    case .cacheFont: DebugCacheScreen<Style.FontKey>()
                    case .cacheSurface: DebugCacheScreen<Style.SurfaceKey>()
                    case .cacheComposition: DebugCacheScreen<Style.CompositionKey>()
                }
            }
            .navigationTitle(title)
        }
        
        var title: String {
            switch self {
                case .rootExamples: "Examples"
                case .rootTools: "Tools"
                case .destination(let title, _): title

                // Examples
                case .structured: "Structured"
                case .componentStack: "Component Stack"

                // Components
                case .card: "Card"
                case .list: "List"
                case .action: "Action"

                case .elements: "Elements"

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
        .environment(\.navigationState, navigationState)
        
    }

}

extension EnvironmentValues {
    @Entry var navigationState: ContentFlow.NavigationState = .init()
}


// MARK: - Preview

#Preview {
    ContentFlow(root: .rootExamples)
}
