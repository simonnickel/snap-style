//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle {

    public struct Element: Hashable, Sendable, CaseIterable {


        // MARK: Element

        public let type: ElementType
        public let hierarchy: Hierarchy

        package init(type: SnapStyle.Element.ElementType, hierarchy: SnapStyle.Element.Hierarchy) {
            self.type = type
            self.hierarchy = hierarchy
        }

        static var any: Self { .init(type: .any, hierarchy: .any) }


        // MARK: ElementType

        public enum ElementType: String, Sendable, CaseIterable {

            case any

            case container

            case title
            case label
            case icon
            case accessory
            case value
            case action
            case separator

        }


        // MARK: Hierarchy

        public enum Hierarchy: String, Sendable, CaseIterable {

            case any

            case primary
            case secondary
            case tertiary

        }


        // MARK: CaseIterable

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


// MARK: - Context

extension SnapStyle.Context {

    public var element: SnapStyle.Element { getValue(for: Self.element) ?? .any }
    package static var element: Attribute<String, SnapStyle.Element> { .init(key: "element", valueDefault: .any) }

}
