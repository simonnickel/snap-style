//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues

extension SnapStyle {
    
    
    // MARK: - Component

    public struct Component: Hashable, Sendable, CaseIterable {
                
        public let type: ComponentType
        public let hierarchy: Hierarchy

        package init(type: SnapStyle.Component.ComponentType, hierarchy: SnapStyle.Component.Hierarchy) {
            self.type = type
            self.hierarchy = hierarchy
        }
        
        static var any: Self { .init(type: .any, hierarchy: .any) }
        
        
        // MARK: ComponentType
        
        public enum ComponentType: String, Sendable, CaseIterable {

            case any

            case screen
            case content
            case list
            case card
            
        }
        
        
        // MARK: Hierarchy
        
        public enum Hierarchy: String, Sendable, CaseIterable {

            case any
            
            case primary
            case secondary
            
        }
        
        
        // MARK: CaseIterable
        
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


// MARK: - Context

extension SnapStyle.Context {
    
    public var component: SnapStyle.Component { getValue(for: Self.component) ?? .any}
    package static var component: Attribute<String, SnapStyle.Component> { .init(key: "component", valueDefault: .any) }
    
}
