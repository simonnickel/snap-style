//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct Item: Hashable, Sendable, CaseIterable {

        public let type: ItemType
        public let hierarchy: Hierarchy

        package init(type: SnapStyle.Item.ItemType, hierarchy: SnapStyle.Item.Hierarchy) {
            self.type = type
            self.hierarchy = hierarchy
        }
        
        public enum ItemType: String, Sendable, CaseIterable {

            case any
            
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
