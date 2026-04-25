//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ExamplesScreen: View {
    
    struct ViewData {
        struct Section: Identifiable {
            var id: String { title }
            let title: String
            let screens: [ExamplesFlow.Screen]
        }
        
        let sections: [Section]
        
        static let examples: ViewData = ViewData(sections: [
            Section(title: "Components", screens: [.card, .list, .action]),
            Section(title: "Examples", screens: [.structured, .componentStack]),
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
        let screens: [ExamplesFlow.Screen]

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
        
        @Environment(\.navigationStateExamples) private var navigationState

        let screen: ExamplesFlow.Screen

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
        ExamplesScreen(data: .examples)
    }
}
