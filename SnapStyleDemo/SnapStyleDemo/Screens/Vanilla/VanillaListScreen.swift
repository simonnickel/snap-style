//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct VanillaListScreen: View {

    var body: some View {
        List {
            ListSection(title: "Section A", rows: 3)
            ListSection(title: "Section B", rows: 7)
            ListSection(title: "Section C", rows: 1)
            ListSection(title: "Section D", rows: 10)
        }
    }


    // MARK: - ListSection

    struct ListSection: View {

        let title: String
        let rows: Int

        var body: some View {
            Section {
                ForEach(0..<rows, id: \.self) { index in
                    ListRow(title: "\(title) - Row \(index)")
                }
            } header: {
                Text(title)
            }
        }
    }


    // MARK: - ListRow

    struct ListRow: View {

        let title: String

        var body: some View {
            NavigationLink(value: VanillaFlow.Screen.destination(title, icon: "star")) {
                Label(title, systemImage: "star")
            }
        }
    }
}


// MARK: - Preview

#Preview {
    VanillaListScreen()
}
