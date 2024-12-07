//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public struct Item: Hashable, Sendable, CaseIterable {

        public let type: ItemType
        public let hierarchy: Hierarchy

        public enum ItemType: String, Sendable, CaseIterable {

            case title
            case content
            case label
            case value
            case cta
            case indicator
        }

        public enum Hierarchy: String, Sendable, CaseIterable {

            case primary
            case secondary
            case tertiary

        }

        public static let allCases: [Item] = {
            var cases: [Item] = []
            for item in ItemType.allCases {
                for hierarchy in Hierarchy.allCases {
                    cases.append(Item(type: item, hierarchy: hierarchy))
                }
            }

            return cases
        }()

    }
}

internal struct ItemModifier: ViewModifier {

    let item: SnapStyle.Item

    func body(content: Content) -> some View {

        content
            .environment(\.styleItem, item)

    }

}

extension View {

    public func style(item: SnapStyle.Item.ItemType, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self
            .modifier(FontFromEnvironmentModifier())
            .modifier(SurfaceFromEnvironmentModifier(layer: .foreground))
            .modifier(SurfaceFromEnvironmentModifier(layer: .background))
            .modifier(ItemModifier(item: SnapStyle.Item(type: item, hierarchy: hierarchy)))
    }

}
