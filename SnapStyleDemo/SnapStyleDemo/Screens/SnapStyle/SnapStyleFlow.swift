//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleDebug
import SnapStyleExamples
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
        
        // Attribtues
        case modifierSurfaceForeground
        case modifierSurfaceBackground

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
                    
                    // Attributes
                    case .modifierSurfaceForeground: ExampleStyleSurfaceForegroundModifier()
                    case .modifierSurfaceBackground: ExampleStyleSurfaceBackgroundModifier()

                }
            }
            .navigationTitle(title)
        }
        
        var title: String {
            switch self {
                case .root: "SnapStyle"
                
                // Layout
                case .viewStyleScreen: "StyleScreen"
                case .viewStyleStack: "StyleStack"
                case .viewStyleSpacer: "StyleSpacer"
                
                // List
                case .viewStyleList: "StyleList"
                case .viewStyleListRow: "StyleListRow"
                case .viewStyleListSectionHeaderLabel: "SectionHeaderLabel"
                case .viewStyleListSectionFooterLabel: "SectionFooterLabel"
                
                // Views
                case .viewScrollingHStack: "ScrollingHStack"
                case .viewStyleFlowLayout: "StyleFlowLayout"
                case .viewCornerContainer: "CornerContainer"
                case .viewStyleButton: "StyleButton"
                
                // Attributes
                case .modifierSurfaceForeground: "Attribute: Surface Foreground"
                case .modifierSurfaceBackground: "Attribute: Surface Background"

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
