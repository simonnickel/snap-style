//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct VanillaContentListScreen: View {

    var body: some View {
        List {
            ListSection(title: "Screens", screens: [
                .rectangle, .triangle, .circle,
            ])
            ListSection(title: "Features", screens: [
                .color(.yellow),
            ])
        }
    }


    // MARK: - ListSection

    struct ListSection: View {

        let title: String
        let screens: [VanillaFlow.Screen]

        var body: some View {
            Section {
                ForEach(screens, id: \.self) { screen in
                    ListRow(screen: screen)
                }
            } header: {
                Text(title)
            }
        }
    }


    // MARK: - ListRow

    struct ListRow: View {

        let screen: VanillaFlow.Screen

        var body: some View {
            NavigationLink(value: screen) {
                Label(screen.title, systemImage: screen.icon)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    VanillaContentListScreen()
}
