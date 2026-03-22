//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct SnapStyleScreen: View {
    
    struct ViewData {
        struct Section: Identifiable {
            var id: String { title }
            let title: String
            let screens: [SnapStyleFlow.Screen]
        }
        
        let sections: [Section]
        
        static let views: ViewData = ViewData(
            sections: [
                Section(
                    title: "Layout",
                    screens: [
                        .viewStyleScreen,
                        .viewStyleStack,
                        .viewStyleSpacer,
                    ]
                ),
                Section(
                    title: "List",
                    screens: [
                        .viewStyleList,
                        .viewStyleListRow,
                        .viewStyleListSectionHeaderLabel,
                        .viewStyleListSectionFooterLabel,
                    ]
                ),
                Section(
                    title: "Views",
                    screens: [
                        .viewStyleFlowLayout,
                        .viewScrollingHStack,
                        .viewCornerContainer,
                        .viewStyleButton,
                    ]
                ),
                Section(
                    title: "Modifier",
                    screens: [
                        .modifierSurfaceForeground,
                        .modifierSurfaceBackground,
                    ]
                ),
            ]
        )
    }
    
    let data: ViewData

    var body: some View {
        StyleList {
            ForEach(data.sections) { section in
                ListSection(title: section.title, screens: section.screens)
            }
        }
    }


    // MARK: - ListSection

    struct ListSection: View {

        let title: String
        let screens: [SnapStyleFlow.Screen]

        var body: some View {
            Section {
                ForEach(screens, id: \.self) { screen in
                    ListRow(screen: screen)
                }
            } header: {
                StyleLabel(title)
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - ListRow

    struct ListRow: View {
        
        @Environment(\.navigationStateSnapStyle) private var navigationState

        let screen: SnapStyleFlow.Screen

        var body: some View {
            StyleListRow(
                .navigate(screen, isPresented: navigationState.stack.contains(screen))
            ) {
                Text(screen.title)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        SnapStyleScreen(data: .views)
    }
}
