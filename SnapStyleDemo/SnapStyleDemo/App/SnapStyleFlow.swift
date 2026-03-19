//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleDebug
import SwiftUI

struct SnapStyleFlow: View {
    
    @Observable class NavigationState {
        var stack: [Screen] = []
    }

    @MainActor
    enum Screen: Hashable, Equatable {
        case root
        
        // Views
        case viewStyleStack
        case viewScrollingHStack

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .root: SnapStyleScreen(data: .views)
                    
                    // Views
                    case .viewStyleStack: StyleStackScreen()
                    case .viewScrollingHStack: ScrollingHStackScreen()

                }
            }
            .navigationTitle(title)
        }
        
        var title: String {
            switch self {
                case .root: "SnapStyle"
                
                // Views
                case .viewStyleStack: "StyleStack"
                case .viewScrollingHStack: "ScrollingHStack"
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
        .environment(\.navigationStateSnapStyle, navigationState)
        
    }

}

extension EnvironmentValues {
    @Entry var navigationStateSnapStyle: SnapStyleFlow.NavigationState = .init()
}


// MARK: - Preview

#Preview {
    SnapStyleFlow(root: .root)
}
