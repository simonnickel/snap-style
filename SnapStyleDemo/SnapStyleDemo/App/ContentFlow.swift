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
        
        /// A generic destination to navigate to.
        case destination(String, source: String)
        
        // Components
        case card
        case list
        case action

        // Examples
        case structured
        case componentStack

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .rootExamples: ContentListScreen(data: .examples)
                        
                    case .destination(let title, source: let source):
                        ComponentListScreen(title: title, source: source)

                    // Components
                    case .card: ComponentCardScreen()
                    case .list: ComponentListScreen(title: self.title, source: "")
                    case .action: ComponentActionScreen()
                        
                        // Examples
                    case .structured: StructuredScreen()
                    case .componentStack: ComponentStackScreen()
                }
            }
            .navigationTitle(title)
        }
        
        var title: String {
            switch self {
                case .rootExamples: "Examples"
                case .destination(let title, _): title
                
                // Components
                case .card: "Card"
                case .list: "List"
                case .action: "Action"
                    
                // Examples
                case .structured: "Structured"
                case .componentStack: "Component Stack"
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
