//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension Style {

    public struct Element: Hashable, Sendable, CaseIterable {


        // MARK: Element

        public let type: ElementType
        public let hierarchy: Hierarchy

        package init(type: Style.Element.ElementType, hierarchy: Style.Element.Hierarchy) {
            self.type = type
            self.hierarchy = hierarchy
        }

        public static var any: Self { .init(type: .any, hierarchy: .any) }


        // MARK: ElementType

        public enum ElementType: String, Sendable, CaseIterable {

            case any

            case container

            case title
            case label
            case icon
            case value
            case accessory
            case separator
            case footnote

        }


        // MARK: Hierarchy

        public enum Hierarchy: String, Identifiable, Sendable, CaseIterable {

            case any

            case primary
            case secondary
            case tertiary
            
            public var id: String { rawValue }

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

extension Style.Context {

    public var element: Style.Element { getValue(for: Self.element) ?? .any }
    package static var element: Attribute<String, Style.Element> { .init(key: "element", valueDefault: .any) }

}
