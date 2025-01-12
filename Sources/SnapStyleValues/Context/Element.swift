//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct Element: Hashable, Sendable, CaseIterable {

        public let type: ElementType
        public let hierarchy: Hierarchy

        package init(type: SnapStyle.Element.ElementType, hierarchy: SnapStyle.Element.Hierarchy) {
            self.type = type
            self.hierarchy = hierarchy
        }
        
        static var any: Self { .init(type: .any, hierarchy: .any) }
        
        public enum ElementType: String, Sendable, CaseIterable {

            case any
            
            case title
            case content
            case label
            case value
            case cta
            case indicator

        }

        public enum Hierarchy: String, Sendable, CaseIterable {

            case any
            
            case primary
            case secondary
            case tertiary

        }

        public static let allCases: [Element] = {
            var cases: [Element] = []
            for element in ElementType.allCases {
                for hierarchy in Hierarchy.allCases {
                    cases.append(Element(type: element, hierarchy: hierarchy))
                }
            }

            return cases
        }()

    }
}
