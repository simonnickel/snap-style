//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ElementStackView: View {

    let axis: Axis
    let hierarchy: SnapStyle.Element.Hierarchy

    init(axis: Axis = .vertical, hierarchy: SnapStyle.Element.Hierarchy = .primary) {
        self.axis = axis
        self.hierarchy = hierarchy
    }

    var body: some View {

        switch axis {
            case .horizontal:
                HStack(alignment: .center) {
                    content
                }

            case .vertical:
                VStack(alignment: .leading) {
                    content
                }
        }

    }

    private var content: some View {
        ForEach(SnapStyle.Element.ElementType.allCases, id: \.self) { elementType in
            Text("\(elementType.rawValue)")
                .style(element: elementType, hierarchy: hierarchy)
        }
    }

}


// MARK: - Preview

#Preview {
    ElementStackView(hierarchy: .primary)
}
