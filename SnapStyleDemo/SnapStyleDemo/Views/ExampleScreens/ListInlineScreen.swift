//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ListInlineScreen: View {
    
    var body: some View {
        StyleScreen {
            content
        }
        .navigationTitle("Structured")
    }
    
    @ViewBuilder
    private var content: some View {
        StyleVStack(spacing: \.spacingSections) {
            ListSectionView(data: .init(title: "Section A", count: 4))
            ListSectionView(data: .init(title: "Section B", count: 6))
        }
        // TODO list: New style of component
//        .style(component: .list)
    }
    
}

#Preview {
    NavigationStack {
        ListInlineScreen()
    }
}
