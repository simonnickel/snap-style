//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct Component: Hashable, Sendable, CaseIterable {
                
        public let type: ComponentType
        public let hierarchy: Hierarchy

        package init(type: SnapStyle.Component.ComponentType, hierarchy: SnapStyle.Component.Hierarchy) {
            self.type = type
            self.hierarchy = hierarchy
        }
        
        public enum ComponentType: String, Sendable, CaseIterable {

            case any

            case screen
            case content
            case list
            case card
            
        }
        
        public enum Hierarchy: String, Sendable, CaseIterable {

            case primary
            case secondary
            
        }
        
        public static let allCases: [Component] = {
            var cases: [Component] = []
            for component in ComponentType.allCases {
                for hierarchy in Hierarchy.allCases {
                    cases.append(Component(type: component, hierarchy: hierarchy))
                }
            }
            
            return cases
        }()
        
    }

}
