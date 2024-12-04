//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum FontKey: String, StyleKey {
        
        /// A key to indicate a missing value.
        case fallback

        // Keys used for `Item`.
        case title
        case content
        case label
        case value
        case cta
        case indicator

        static func key(for item: SnapStyle.Item) -> SnapStyle.FontKey {
            switch item {
                case .title: .title
                case .content: .content
                case .label: .label
                case .value: .value
                case .cta: .cta
                case .indicator: .indicator
            }
        }

    }
    
}


// MARK: - Value

extension SnapStyle.FontKey {
    
    public enum Value {
        case definition(Definition)
        case font(Font)
        case reference(SnapStyle.FontKey)
        
        var wrappedValue: Font {
            switch self {
                case .definition(let definition): Font.system(size: definition.size)
                case .font(let font): font
                case .reference(let key):
                    fatalError("A `.reference` FontValue should never be used to generate a value.")
            }
        }
    }
    
    public struct Definition {
        
        let size: CGFloat

        public init(size: CGFloat) {
            self.size = size
        }
        
    }
    
}


// MARK: - SnapStyle Getter

extension SnapStyle {

    internal func font(for key: FontKey, in component: SnapStyle.Component, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> Font? {

        guard let valueBuilder = fonts[key] else {
            return fonts[.fallback]?(component, hierarchy)?.wrappedValue ?? FontValues.values(for: FontKey.fallback)(component, hierarchy)?.wrappedValue
        }

        let value = valueBuilder(component, hierarchy) ?? FontValues.defaultValues[key]?(component, hierarchy)

        return switch value {
            case .reference(let key): font(for: key, in: component, hierarchy: hierarchy)
            default: value?.wrappedValue
        }
    }

}
