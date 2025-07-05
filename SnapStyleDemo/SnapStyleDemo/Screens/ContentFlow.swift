//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleDebug
import SwiftUI

struct ContentFlow: View {

    @MainActor
    enum Screen: Hashable, Equatable {
        case root
        
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
                    case .root: ContentListScreen()
                        
                    case .destination(let title, source: let source):
                        ComponentListScreen(title: title, source: source)

                    // Examples
                    case .structured: StructuredScreen()
                    case .componentStack: ComponentStackScreen()

                    // Components
                    case .card: ComponentCardScreen()
                    case .list: ComponentListScreen(title: self.title, source: "")
                    case .action: ComponentActionScreen()

                    case .elements: DebugElementScreen(components: [.screen, .contentCard, .accentCard, .valueCard, .list, .listRow])

                    case .cacheNumber: DebugCacheScreen<SnapStyle.NumberKey>()
                    case .cacheFont: DebugCacheScreen<SnapStyle.FontKey>()
                    case .cacheSurface: DebugCacheScreen<SnapStyle.SurfaceKey>()
                    case .cacheComposition: DebugCacheScreen<SnapStyle.CompositionKey>()
                }
            }
            .navigationTitle(title)
        }
        
        var title: String {
            switch self {
                case .root: "SnapStyle"
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

    @State private var navigationState: [Screen] = []

    var body: some View {
        
        NavigationStack(path: $navigationState) {
            Screen.root.screen
                .navigationDestination(for: Screen.self) { screen in
                    screen.screen
                }
        }
        .environment(\.navigationState, navigationState)
        
    }

}

extension EnvironmentValues {
    @Entry var navigationState: [ContentFlow.Screen] = []
}


// MARK: - Preview

#Preview {
    ContentFlow()
}
