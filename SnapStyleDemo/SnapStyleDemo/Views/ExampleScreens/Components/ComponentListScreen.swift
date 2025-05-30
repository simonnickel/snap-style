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
                StyleListRow(.plain) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.plain) {
                    StyleLabel("Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.plain) {
                    StyleLabel("Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel("Variant .plain")
                    .style(element: .title)
            }
        }
    }
    
    
    // MARK: - SectionVariantNavigate
    
    struct SectionVariantNavigate: View {
        
        var body: some View {
            Section {
                StyleListRow(.navigate("Star")) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.navigate("Rectangle")) {
                    StyleLabel("Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.navigate("Triangle")) {
                    StyleLabel("Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel("Variant .navigate")
                    .style(element: .title)
            }
        }
    }
    
    
    // MARK: - SectionVariantSelectValue
    
    struct SectionVariantSelectValue: View {
        
        @State private var selection: String = "Star"
        
        var body: some View {
            Section {
                StyleListRow(.selectValue("Star", selection: $selection)) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.selectValue("Rectangle", selection: $selection)) {
                    StyleLabel("Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.selectValue("Triangle", selection: $selection)) {
                    StyleLabel("Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel("Variant .selectValue")
                    .style(element: .title)
            }
        }
    }
    
    
    // MARK: - SectionVariantSelectValues
    
    struct SectionVariantSelectValues: View {
        
        @State private var selection: [String] = []
        
        var body: some View {
            Section {
                StyleListRow(.selectValues("Star", selection: $selection)) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.selectValues("Rectangle", selection: $selection)) {
                    StyleLabel("Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.selectValues("Triangle", selection: $selection)) {
                    StyleLabel("Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel("Variant .selectValues")
                    .style(element: .title)
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
                StyleListRow(.selected($isSelectedStar)) {
                    StyleLabel("Star (Binding)", systemImage: "star")
                }
                StyleListRow(.selected($isSelectedRectangle)) {
                    StyleLabel("Rectangle (Binding)", systemImage: "rectangle")
                }
                StyleListRow(.selected($isSelectedTriangle)) {
                    StyleLabel("Triangle (Binding)", systemImage: "triangle")
                }
            } header: {
                StyleLabel("Variant .selected")
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
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.enabled($enabledRectangle)) {
                    StyleLabel("Rectangle", systemImage: "rectangle")
                }
                StyleListRow(.enabled($enabledTriangle)) {
                    StyleLabel("Triangle", systemImage: "triangle")
                }
            } header: {
                StyleLabel("Variant .enabled")
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
                StyleLabel(data.title)
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
                        StyleLabel(data.title, systemImage: data.icon)
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
