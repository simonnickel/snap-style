//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    public func styleListSectionHeaderLabel(hierarchy: SnapStyle.Element.Hierarchy = .secondary) -> some View {
        self
            .modifier(ListSectionHeaderLabel(hieararchy: hierarchy))
    }
    
}


// MARK: - Modifier

internal struct ListSectionHeaderLabel: ViewModifier {
    
    let hieararchy: SnapStyle.Element.Hierarchy
    
    func body(content: Content) -> some View {
        content
            .style(element: .title, hierarchy: hieararchy)
            .textCase(nil)
    }
    
}


// MARK: - Preview

#Preview {
    StyleList {
        Section {
            StyleLabel("Row")
            StyleLabel("Row")
        } header: {
            StyleLabel("Header .primary")
                .styleListSectionHeaderLabel(hierarchy: .primary)
        }

        Section {
            StyleLabel("Row")
            StyleLabel("Row")
        } header: {
            StyleLabel("Header .secondary (default)")
                .styleListSectionHeaderLabel()
        }
        
        Section {
            StyleLabel("Row")
            StyleLabel("Row")
        } header: {
            StyleLabel("Header .tertiary")
                .styleListSectionHeaderLabel(hierarchy: .tertiary)
        }
        
        Section {
            StyleLabel("Row")
            StyleLabel("Row")
        } header: {
            StyleLabel("Header")
        }
    }
}
