//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ElementsView: View {
    
    @ScaledNumber(\.spacingElements) var spacingH

    let hierarchy: Style.Element.Hierarchy

    init(hierarchy: Style.Element.Hierarchy = .primary) {
        self.hierarchy = hierarchy
    }

    var body: some View {
        
        StyleFlowLayout(spacingH: spacingH) {
            content
        }

    }

    private var content: some View {
        ForEach(Style.Element.ElementType.allCases, id: \.self) { elementType in
            Text("\(elementType.rawValue)")
                .style(element: elementType, hierarchy: hierarchy)
        }
    }

}


// MARK: - Preview

#Preview {
    ElementsView(hierarchy: .primary)
}
