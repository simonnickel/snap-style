//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum Item {
        case title, cta, content, label, value

        public enum Hierarchy: CaseIterable {

            case primary
            case secondary
            case tertiary

        }
    }

}

internal struct ItemModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let item: SnapStyle.Item
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        switch item {
        case .title: title(content)
        case .cta: cta(content)
        case .content: conten(content)
        case .label: label(content)
        case .value: value(content)
        }
    }

    private func title(_ content: Content) -> some View {
        content
            .style(font: .title, hierarchy: hierarchy)
    }
    private func cta(_ content: Content) -> some View {
        content
            .style(font: .cta)
    }
    private func conten(_ content: Content) -> some View {
        content
            .style(font: .block)
    }
    private func label(_ content: Content) -> some View {
        content
            .font(.title)
    }
    private func value(_ content: Content) -> some View {
        content
            .font(.title)
    }

}

extension View {

    public func style(item: SnapStyle.Item, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self.modifier(ItemModifier(item: item, hierarchy: hierarchy))
    }

}
