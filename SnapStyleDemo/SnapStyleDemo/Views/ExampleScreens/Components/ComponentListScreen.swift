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
            ListSectionView(data: .init(title: "Section 2", count: 8), selection: $selected)
            ListSectionView(data: .init(title: "Section 3", count: 18), selection: $selected)
        }
        
    }
    
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
    ComponentListScreen()
}
