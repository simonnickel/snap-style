//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ToolsScreen: View {
    
    struct ViewData {
        struct Section: Identifiable {
            var id: String { title }
            let title: String
            let screens: [ToolsFlow.Screen]
        }
        
        let sections: [Section]
        
        static let tools: ViewData = ViewData(sections: [
            Section(title: "Tools", screens: [.components]),
            Section(title: "Caches", screens: [.cacheNumber, .cacheFont, .cacheSurface, .cacheComposition]),
        ])
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
        let screens: [ToolsFlow.Screen]

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
        
        @Environment(\.navigationStateTools) private var navigationState

        let screen: ToolsFlow.Screen

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
        ToolsScreen(data: .tools)
    }
}
