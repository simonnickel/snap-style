//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

extension View {

    public func styleListSectionHeaderLabel(
        hierarchy: Style.Element.Hierarchy = .secondary
    ) -> some View {
        modifier(ListSectionHeaderLabel(hieararchy: hierarchy))
    }

}


// MARK: - Modifier

internal struct ListSectionHeaderLabel: ViewModifier {

    let hieararchy: Style.Element.Hierarchy

    func body(content: Content) -> some View {
        content
            .style(padding: \.paddingListRowLeading, .leading)
            .style(padding: \.paddingListHeaderBottom, .bottom)
            .style(element: .title, hierarchy: hieararchy)
            .textCase(nil)
    }

}


// MARK: - Preview

#Preview {
    StyleList {
        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header .primary")
                .styleListSectionHeaderLabel(hierarchy: .primary)
        }

        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header .secondary (default)")
                .styleListSectionHeaderLabel()
        }

        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header .tertiary")
                .styleListSectionHeaderLabel(hierarchy: .tertiary)
        }

        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header")
        }
    }
}
