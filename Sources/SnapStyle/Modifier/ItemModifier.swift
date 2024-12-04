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

        public enum Hierarchy: CaseIterable {

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
        switch item {
            case .title: title(content)
            case .content: conten(content)
            case .label: label(content)
            case .value: value(content)
            case .cta: cta(content)
            case .indicator: indicator(content)
        }
    }

    private func title(_ content: Content) -> some View {
        content
            .style(font: .title, hierarchy: hierarchy)
            .color(.title, hierarchy: hierarchy)
    }

    private func conten(_ content: Content) -> some View {
        content
            .style(font: .content, hierarchy: hierarchy)
            .color(.content, hierarchy: hierarchy)
    }

    private func label(_ content: Content) -> some View {
        content
            .style(font: .label, hierarchy: hierarchy)
            .color(.label, hierarchy: hierarchy)
    }

    private func value(_ content: Content) -> some View {
        content
            .style(font: .value, hierarchy: hierarchy)
            .color(.value, hierarchy: hierarchy)
    }

    private func cta(_ content: Content) -> some View {
        content
            .style(font: .cta, hierarchy: hierarchy)
            .color(.cta, hierarchy: hierarchy)
    }

    private func indicator(_ content: Content) -> some View {
        content
            .style(font: .indicator, hierarchy: hierarchy)
            .color(.indicator, hierarchy: hierarchy)
    }

}

extension View {

    public func style(item: SnapStyle.Item, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self.modifier(ItemModifier(item: item, hierarchy: hierarchy))
    }

}
