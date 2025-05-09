//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

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
                data.append(.init(title: "Item \(index)", icon: icons[index % icons.count]))
            }
            self.items = data
        }
    }

    let data: Data
    @State private var selected: UUID?
    
    var body: some View {
        Section {
            ForEach(data.items) { item in
                ListItemView(data: item, isSelected: item.id == selected)
            }
        } header: {
            StyleLabel(title: data.title)
                .style(element: .title)
        }
        // TODO: Selection
        .onAppear {
            selected = data.items.first?.id
        }
    }
    
    struct ListItemView: View {
        
        struct Data: Identifiable {
            let id: UUID = UUID()
            let title: String
            let icon: String
        }
        
        let data: Data
        let isSelected: Bool
        
        var body: some View {
            StyleLabel(title: data.title, systemImage: data.icon)
                .style(component: .listRow, state: isSelected ? .selected : .normal)
        }
    }

}


// MARK: - Preview

#Preview {
    StyleList {
        ListSectionView(data: .init(title: "Preview", count: 30))
    }
}
