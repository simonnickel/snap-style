//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentListScreen: View {
    
    @State private var selected: String? = nil
    
    var body: some View {
        
        StyleList(selection: $selected) {
            SectionVariantPlain()
            SectionVariantNavigate()
            SectionVariantSelectValue()
            SectionVariantSelectValues()
            SectionVariantSelected()
            SectionVariantEnabled()
            ListSectionView(data: .init(title: "Section 2", count: 8), selection: $selected)
            ListSectionView(data: .init(title: "Section 3", count: 18), selection: $selected)
        }
        .navigationDestination(for: String.self) { value in
            Text(value)
        }
        
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
        
        var body: some View {
            Section {
                StyleListRow(.navigate("Star"), systemImage: "star") {
                    Text("Star")
                }
                StyleListRow(.navigate("Rectangle"), systemImage: "rectangle") {
                    Text("Rectangle")
                }
                StyleListRow(.navigate("Triangle"), systemImage: "triangle") {
                    Text("Triangle")
                }
            } header: {
                StyleLabel("Variant .navigate")
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
        
        var body: some View {
            Section {
                ForEach(data.items) { item in
                    ListItemView(data: item, selection: $selection)
                }
            } header: {
                StyleLabel(data.title)
                    .styleListSectionHeaderLabel()
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
            
            var body: some View {
                StyleListRow(systemImage: data.icon, isSelected: selection ?? "" == data.id) {
                    // TODO: Button should have no styling here.
                    Button {
                        selection = data.id
                    } label: {
                        Text(data.title)
                    }
                }
            }
        }

    }
}


// MARK: - Previews

#Preview {
    NavigationStack {
        ComponentListScreen()
    }
}
