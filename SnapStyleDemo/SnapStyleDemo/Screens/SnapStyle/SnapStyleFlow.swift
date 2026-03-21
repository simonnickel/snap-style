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
        
        // Layout
        case viewStyleScreen
        case viewStyleStack
        case viewStyleSpacer

        // List
        case viewStyleList
        case viewStyleListRow
        case viewStyleListSectionHeaderLabel
        case viewStyleListSectionFooterLabel
        
        // Views
        case viewStyleFlowLayout
        case viewScrollingHStack
        case viewCornerContainer
        case viewStyleButton

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .root: SnapStyleScreen(data: .views)
                    
                    // Layout
                    case .viewStyleScreen: StyleScreenScreen()
                    case .viewStyleStack: StyleStackScreen()
                    case .viewStyleSpacer: StyleSpacerScreen()
                    
                    // List
                    case .viewStyleList: StyleListScreen()
                    case .viewStyleListRow: StyleListRowScreen()
                    case .viewStyleListSectionHeaderLabel: StyleListSectionHeaderLabelScreen()
                    case .viewStyleListSectionFooterLabel: StyleListSectionFooterLabelScreen()
                    
                    // Views
                    case .viewStyleFlowLayout: StyleFlowLayoutScreen()
                    case .viewScrollingHStack: ScrollingHStackScreen()
                    case .viewCornerContainer: CornerContainerScreen()
                    case .viewStyleButton: StyleButtonScreen()

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
                case .viewStyleFlowLayout: "StyleFlowLayout"
                case .viewStyleScreen: "StyleScreen"
                case .viewStyleList: "StyleList"
                case .viewStyleListRow: "StyleListRow"
                case .viewStyleListSectionHeaderLabel: "SectionHeaderLabel"
                case .viewStyleListSectionFooterLabel: "SectionFooterLabel"
                case .viewStyleSpacer: "StyleSpacer"
                case .viewStyleButton: "StyleButton"
                case .viewCornerContainer: "CornerContainer"
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
