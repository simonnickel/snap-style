//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SnapStyleDebug
import SwiftUI

struct ContentFlow: View {
    
    @MainActor
    enum Screen: String {
        case content
        case card
        case list
        case action
        case componentStack
        
        case components
        case structured
        
        case elements
        
        case cacheNumber = "Number"
        case cacheFont = "Font"
        case cacheSurface = "Surface"
        case cacheComposition = "Composition"
        
        var title: String {
            rawValue.capitalized
        }
        
        @ViewBuilder
        var screen: some View {
            switch self {
                case .content: ComponentContentScreen()
                case .card: ComponentCardScreen()
                case .list: ComponentListScreen()
                case .action: ComponentActionScreen()
                case .componentStack: ComponentStackScreen()
                case .components: ComponentsScreen()
                case .structured: StructuredScreen()
                case .elements: DebugKeyScreen()
                case .cacheNumber: DebugCacheScreen<SnapStyle.NumberKey>()
                case .cacheFont: DebugCacheScreen<SnapStyle.FontKey>()
                case .cacheSurface: DebugCacheScreen<SnapStyle.SurfaceKey>()
                case .cacheComposition: DebugCacheScreen<SnapStyle.CompositionKey>()
            }
        }
    }
    
    @State private var navigationPath: [Screen] = []
    
    var body: some View {
        NavigationStack {
            List {
                ListSection(title: "Components", screens: [.content, .card, .list, .action, .componentStack])
                ListSection(title: "Examples", screens: [.components, .structured])
                ListSection(title: "Compon", screens: [.elements])
                ListSection(title: "Caches", screens: [.cacheNumber, .cacheFont, .cacheSurface, .cacheComposition])
            }
            .setupNavigationToolbar()
            .navigationDestination(for: Screen.self) { screen in
                screen.screen
                    .navigationTitle(screen.title)
                    .setupNavigationToolbar()
            }
        }
    }
    
    
    // MARK: - ListSection
    
    struct ListSection: View {
        
        let title: String
        let screens: [Screen]
        
        var body: some View {
            Section {
                ForEach(screens, id: \.self) { screen in
                    ListRow(screen: screen)
                }
            } header: {
                Text(title)
            }
        }
    }
    
    
    // MARK: - ListRow
    
    struct ListRow: View {
        
        let screen: Screen
        
        var body: some View {
            NavigationLink(value: screen) {
                Text(screen.title)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    ContentFlow()
        .styleOverride(
            fonts: [
                \.title : SnapStyle.ValueBuilder.builder { context in
                    switch context.element.hierarchy {
                        case.primary: .definition(.with(size: 12))
                        default: nil
                    }

                }
            ]
        )
}
