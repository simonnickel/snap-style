//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

extension View {

    public func styleListSectionFooterLabel() -> some View {
        modifier(ListSectionFooterLabel())
    }

}


// MARK: - Modifier

internal struct ListSectionFooterLabel: ViewModifier {

    func body(content: Content) -> some View {
        content
            .style(padding: \.paddingListRowLeading, .leading)
            .style(padding: \.paddingListFooterTop, .top)
            .style(element: .footnote)
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
        } footer: {
            StyleLabel("Footer")
                .styleListSectionFooterLabel()
        }

        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header .secondary (default)")
                .styleListSectionHeaderLabel()
        } footer: {
            StyleLabel("Footer")
                .styleListSectionFooterLabel()
        }

        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header .tertiary")
                .styleListSectionHeaderLabel(hierarchy: .tertiary)
        } footer: {
            StyleLabel("Footer")
                .styleListSectionFooterLabel()
        }

        Section {
            StyleListRow { Text("Row") }
            StyleListRow { Text("Row") }
        } header: {
            StyleLabel("Header")
        } footer: {
            StyleLabel("Footer")
        }
    }
}
