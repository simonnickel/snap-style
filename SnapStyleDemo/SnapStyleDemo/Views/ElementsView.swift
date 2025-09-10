//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ElementsView: View {

    let hierarchy: Style.Element.Hierarchy

    init(hierarchy: Style.Element.Hierarchy = .primary) {
        self.hierarchy = hierarchy
    }

    var body: some View {
        
        StyleFlowLayout(spacing: \.spacingElements) {
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
