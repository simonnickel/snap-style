//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ListNativeScreen: View {
    var body: some View {
        List {
            ListSectionView(data: .init(title: "Section A", count: 4))
            ListSectionView(data: .init(title: "Section B", count: 6))
        }
        // TODO: New style of component
//        .style(component: .list, applyStyle: false) // TODO: Apply style or remove font/surface from component. Currently applyStyle overrides tint color.
    }
}

#Preview {
    NavigationStack {
        ListNativeScreen()
    }
}
