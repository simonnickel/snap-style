//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentListScreen: View {
    var body: some View {
        
        StyleList {
            ListSectionView(data: .init(title: "Section 1", count: 3))
            ListSectionView(data: .init(title: "Section 2", count: 8))
            ListSectionView(data: .init(title: "Section 3", count: 18))
        }
        
    }
}


// MARK: - Previews

#Preview {
    ComponentListScreen()
}
