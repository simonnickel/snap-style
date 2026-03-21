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
        modifier(ListSectionHeaderLabel(hierarchy: hierarchy))
    }

}


// MARK: - Modifier

internal struct ListSectionHeaderLabel: ViewModifier {

    let hierarchy: Style.Element.Hierarchy

    func body(content: Content) -> some View {
        content
            .style(padding: \.listSectionHeader)
            .style(element: .title, hierarchy: hierarchy)
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

#Preview("Example") {
    StyleListSectionHeaderLabelExample()
}


package struct StyleListSectionHeaderLabelExample: View {

    package init() {}

    package var body: some View {
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
}
