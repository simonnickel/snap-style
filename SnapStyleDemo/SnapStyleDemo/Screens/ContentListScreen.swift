//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ContentListScreen: View {

    var body: some View {
        StyleList {
            ListSection(title: "Examples", screens: [.structured, .componentStack])
            ListSection(title: "Components", screens: [.card, .list, .action])
            ListSection(title: "Compon", screens: [.elements])
            ListSection(title: "Caches", screens: [.cacheNumber, .cacheFont, .cacheSurface, .cacheComposition])
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
                .navigate(screen, isPresented: { screen in
                    navigationState.contains(screen)
                })
            ) {
                Text(screen.title)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        ContentListScreen()
    }
}
