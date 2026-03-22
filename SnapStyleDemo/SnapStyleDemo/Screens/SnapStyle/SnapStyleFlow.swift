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
        case modifierComposition
        case modifierFont
        case modifierPadding
        case modifierShape

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .root: SnapStyleScreen(data: .views)
                    
                    // Layout
                    case .viewStyleScreen: ExampleStyleScreen()
                    case .viewStyleStack: ExampleStyleStack()
                    case .viewStyleSpacer: ExampleStyleSpacer()
                    
                    // List
                    case .viewStyleList: ExampleStyleList()
                    case .viewStyleListRow: ExampleStyleListRow()
                    case .viewStyleListSectionHeaderLabel: ExampleStyleListSectionHeaderLabel()
                    case .viewStyleListSectionFooterLabel: ExampleStyleListSectionFooterLabel()
                    
                    // Views
                    case .viewStyleFlowLayout: ExampleStyleFlowLayout()
                    case .viewScrollingHStack: ExampleScrollingHStack()
                    case .viewCornerContainer: ExampleCornerContainer()
                    case .viewStyleButton: ExampleStyleButton()
                    
                    // Attributes
                    case .modifierSurfaceForeground: ExampleStyleSurfaceForegroundModifier()
                    case .modifierSurfaceBackground: ExampleStyleSurfaceBackgroundModifier()
                    case .modifierComposition: ExampleStyleCompositionModifier()
                    case .modifierFont: ExampleStyleFontModifier()
                    case .modifierPadding: ExampleStylePaddingModifier()
                    case .modifierShape: ExampleStyleShapeModifier()

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
                
                // Modifier
                case .modifierSurfaceForeground: "Attribute: Surface Foreground"
                case .modifierSurfaceBackground: "Attribute: Surface Background"
                case .modifierComposition: "Attribute: Composition"
                case .modifierFont: "Attribute: Font"
                case .modifierPadding: "Attribute: Padding"
                case .modifierShape: "Attribute: Shape"

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
