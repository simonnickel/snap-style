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
            ListSectionView(data: .init(title: "Section 1", count: 3), selection: $selected)
            SectionVariantNavigate()
            SectionVariantSelected()
            SectionVariantEnabled()
            ListSectionView(data: .init(title: "Section 2", count: 8), selection: $selected)
            ListSectionView(data: .init(title: "Section 3", count: 18), selection: $selected)
        }
        .navigationDestination(for: String.self) { value in
            Text(value)
        }
        
    }
    
    
    // MARK: - SectionVariantNavigate
    
    struct SectionVariantNavigate: View {
        
        var body: some View {
            Section {
                StyleListRow(.navigate("Star")) {
                    StyleLabel(title: "Star", systemImage: "star")
                }
                StyleListRow(.navigate("Rectangle")) {
                    StyleLabel(title: "Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.navigate("Triangle")) {
                    StyleLabel(title: "Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel(title: "Variant .navigate")
                    .style(element: .title)
            }
        }
    }
    
    
    // MARK: - SectionVariantSelected
    
    struct SectionVariantSelected: View {
        
        @State private var selected: String? = "Star"
        
        var body: some View {
            Section {
                StyleListRow(.selected(selected == "Star")) {
                    StyleLabel(title: "Star", systemImage: "star")
                }
                StyleListRow(.selected(selected == "Rectangle")) {
                    StyleLabel(title: "Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.selected(selected == "Triangle")) {
                    StyleLabel(title: "Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel(title: "Variant .selected")
                    .style(element: .title)
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
                StyleListRow(.enabled($enabledStar)) {
                    StyleLabel(title: "Star", systemImage: "star")
                }
                StyleListRow(.enabled($enabledRectangle)) {
                    StyleLabel(title: "Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.enabled($enabledTriangle)) {
                    StyleLabel(title: "Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel(title: "Variant .enabled")
                    .style(element: .title)
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
                StyleLabel(title: data.title)
                    .style(element: .title)
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
                StyleListRow(isSelected: selection ?? "" == data.id) {
                    // TODO: Button should have no styling here.
                    Button {
                        selection = data.id
                    } label: {
                        StyleLabel(title: data.title, systemImage: data.icon)
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
