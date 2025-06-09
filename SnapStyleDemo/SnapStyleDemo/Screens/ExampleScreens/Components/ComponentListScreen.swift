//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentListScreen: View {
    
    let title: String
    let source: String

    @State private var selected: String? = nil

    var body: some View {

        StyleList(selection: $selected) {
            SectionVariantPlain()
            SectionVariantNavigate(title: title, source: source)
            SectionVariantPick()
            SectionVariantEnabled()
            SectionVariantSelectValue()
            SectionVariantSelectValues()
            SectionVariantSelected()
            SectionVariantNoIcon()
            ListSectionView(data: .init(title: "Section", count: 1), selection: $selected, applyStyle: true)
            ListSectionView(data: .init(title: "Section", count: 10), selection: $selected, applyStyle: true)
            ListSectionView(data: .init(title: "Section", count: 30), selection: $selected, applyStyle: true)
        }
        .navigationTitle(title)

    }


    // MARK: - SectionVariantPlain

    struct SectionVariantPlain: View {

        var body: some View {
            Section {
                StyleListRow(.plain, systemImage: "star") {
                    Text("Star")
                }
                StyleListRow(.plain, systemImage: "rectangle") {
                    Text("Rectangle")
                }
                StyleListRow(.plain, systemImage: "triangle") {
                    Text("Triangle")
                }
            } header: {
                StyleLabel("Variant .plain")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantNavigate

    struct SectionVariantNavigate: View {

        @Environment(\.navigationState) private var navigationState
        
        let title: String
        let source: String
        
        private var identifier: String {
            "\(source)-\(title)"
        }

        var body: some View {
            Section {
                StyleListRow(
                    .navigate(
                        ContentFlow.Screen.destination("Star", source: identifier),
                        isPresented: { screen in
                            navigationState.contains(screen)
                        }),
                    systemImage: "star"
                ) {
                    Text("Star")
                }
                StyleListRow(
                    .navigate(
                        ContentFlow.Screen.destination("Rectangle", source: identifier),
                        isPresented: { screen in
                            navigationState.contains(screen)
                        }),
                    systemImage: "rectangle"
                ) {
                    Text("Rectangle")
                }
                StyleListRow(
                    .navigate(
                        ContentFlow.Screen.destination("Triangle", source: identifier),
                        isPresented: { screen in
                            navigationState.contains(screen)
                        }),
                    systemImage: "triangle"
                ) {
                    Text("Triangle")
                }
            } header: {
                StyleLabel("Variant .navigate")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantPick

    struct SectionVariantPick: View {

        @State private var selected: String = "A"

        var body: some View {
            Section {
                StyleListRow(.pick(["A", "B", "C"], selection: $selected), systemImage: "star") {
                    Text("Star")
                }
            } header: {
                StyleLabel("Variant .pick")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantEnabled

    struct SectionVariantEnabled: View {

        @State private var enabledStar: Bool = false
        @State private var enabledRectangle: Bool = false
        @State private var enabledTriangle: Bool = false

        var body: some View {
            Section {
                StyleListRow(.enabled($enabledStar), systemImage: "star") {
                    Text("Star")
                }
                StyleListRow(.enabled($enabledRectangle), systemImage: "rectangle") {
                    Text("Rectangle")
                }
                StyleListRow(.enabled($enabledTriangle), systemImage: "triangle") {
                    Text("Triangle")
                }
            } header: {
                StyleLabel("Variant .enabled")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantSelectValue

    struct SectionVariantSelectValue: View {

        @State private var selection: String = "Star"

        var body: some View {
            Section {
                StyleListRow(.selectValue("Star", selection: $selection), systemImage: "star") {
                    Text("Star")
                }
                StyleListRow(.selectValue("Rectangle", selection: $selection), systemImage: "rectangle") {
                    Text("Rectangle")
                }
                StyleListRow(.selectValue("Triangle", selection: $selection), systemImage: "triangle") {
                    Text("Triangle")
                }
            } header: {
                StyleLabel("Variant .selectValue")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantSelectValues

    struct SectionVariantSelectValues: View {

        @State private var selection: [String] = []

        var body: some View {
            Section {
                StyleListRow(.selectValues("Star", selection: $selection), systemImage: "star") {
                    Text("Star")
                }
                StyleListRow(.selectValues("Rectangle", selection: $selection), systemImage: "rectangle") {
                    Text("Rectangle")
                }
                StyleListRow(.selectValues("Triangle", selection: $selection), systemImage: "triangle") {
                    Text("Triangle")
                }
            } header: {
                StyleLabel("Variant .selectValues")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantSelected

    struct SectionVariantSelected: View {

        @State private var isSelectedStar: Bool = false
        @State private var isSelectedRectangle: Bool = false
        @State private var isSelectedTriangle: Bool = false

        var body: some View {
            Section {
                StyleListRow(.selected($isSelectedStar), systemImage: "star") {
                    Text("Star (Binding)")
                }
                StyleListRow(.selected($isSelectedRectangle), systemImage: "rectangle") {
                    Text("Rectangle (Binding)")
                }
                StyleListRow(.selected($isSelectedTriangle), systemImage: "triangle") {
                    Text("Triangle (Binding)")
                }
            } header: {
                StyleLabel("Variant .selected")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - SectionVariantPlain

    struct SectionVariantNoIcon: View {

        @State private var enabledTriangle: Bool = false
        @State private var enabledCircle: [String] = []

        var body: some View {
            Section {
                StyleListRow(.plain) {
                    Text("Star")
                }
                StyleListRow(.navigate("Rectangle")) {
                    Text("Rectangle")
                }
                StyleListRow(.enabled($enabledTriangle)) {
                    Text("Triangle")
                }
                StyleListRow(.selectValues("Circle", selection: $enabledCircle)) {
                    Text("Circle")
                }
            } header: {
                StyleLabel("No Icons")
                    .styleListSectionHeaderLabel()
            }
        }
    }


    // MARK: - ListSectionView

    struct ListSectionView: View {

        struct Data {
            let title: String
            let items: [ListSectionView.ListItemView.Data]

            init(title: String, items: [ListSectionView.ListItemView.Data]) {
                self.title = title
                self.items = items
            }

            private let icons: [String] = ["circle", "triangle", "rectangle", "pentagon", "hexagon", "star"]

            init(title: String, count: Int) {
                self.title = title
                var data: [ListSectionView.ListItemView.Data] = []
                for index in 0..<count {
                    data.append(.init(title: "\(title) - Item \(index)", icon: icons[index % icons.count]))
                }
                self.items = data
            }
        }

        let data: Data
        @Binding var selection: String?
        let applyStyle: Bool

        var body: some View {
            Section {
                ForEach(data.items) { item in
                    ListItemView(data: item, selection: $selection, applyStyle: applyStyle)
                }
            } header: {
                if applyStyle {
                    StyleLabel(data.title)
                        .styleListSectionHeaderLabel()
                } else {
                    Text(data.title)
                }
            }
        }


        // MARK: ListItemView

        struct ListItemView: View {

            struct Data: Identifiable {
                var id: String { title }
                let title: String
                let icon: String
            }

            let data: Data
            @Binding var selection: String?
            let applyStyle: Bool

            var body: some View {
                if applyStyle {
                    StyleListRow(systemImage: data.icon) {
                        selection = data.id
                    } title: {
                        Text(data.title)
                    }
                } else {
                    Button {
                        selection = data.id
                    } label: {
                        Label(data.title, systemImage: data.icon)
                    }
                }
            }
        }

    }
}


// MARK: - Previews

#Preview {
    NavigationStack {
        ComponentListScreen(title: "List", source: "Preview")
    }
}
