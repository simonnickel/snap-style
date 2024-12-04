//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum Item {
        
        case title
        case content
        case label
        case value
        case cta
        case indicator

        public enum Hierarchy: Sendable, CaseIterable {

            case primary
            case secondary
            case tertiary

        }
    }

}

internal struct ItemModifier: ViewModifier {

    @Environment(\.style) private var style

    let item: SnapStyle.Item
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {

        content
            .style(font: SnapStyle.FontKey.key(for: item), hierarchy: hierarchy)
            .style(surface: SnapStyle.SurfaceKey.key(for: item), hierarchy: hierarchy)

    }

}

extension View {

    public func style(item: SnapStyle.Item, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self.modifier(ItemModifier(item: item, hierarchy: hierarchy))
    }

}
