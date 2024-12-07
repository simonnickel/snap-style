//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public struct Component: Hashable, Sendable, CaseIterable {
        
        public let type: ComponentType
        public let hierarchy: Hierarchy
        
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

extension View {

    public func style(component: SnapStyle.Component.ComponentType, hierarchy: SnapStyle.Component.Hierarchy = .primary) -> some View {
        self.environment(\.styleComponent, .init(type: component, hierarchy: hierarchy))
    }

}
