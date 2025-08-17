//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ContentListScreen: View {
    
    struct ViewData {
        struct Section: Identifiable {
            var id: String { title }
            let title: String
            let screens: [ContentFlow.Screen]
        }
        
        let sections: [Section]
        
        static let examples: ViewData = ViewData(sections: [
            Section(title: "Components", screens: [.card, .list, .action]),
            Section(title: "Examples", screens: [.structured, .componentStack]),
        ])
        static let tools: ViewData = ViewData(sections: [
            Section(title: "Tools", screens: [.elements]),
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
        let screens: [ContentFlow.Screen]

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
        
        @Environment(\.navigationState) private var navigationState

        let screen: ContentFlow.Screen

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
        ContentListScreen(data: .examples)
    }
}
