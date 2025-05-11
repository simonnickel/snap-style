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
        case root = "SnapStyle"
        
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
            rawValue.uppercasedFirstLetter
        }
        
        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .root: ContentListScreen()
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
            .navigationTitle(title)
        }
    }
    
    @State private var navigationPath: [Screen] = []
    
    var body: some View {
        NavigationStack {
            Screen.root.screen
                .navigationDestination(for: Screen.self) { screen in
                    screen.screen
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
