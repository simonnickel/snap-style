//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public enum FontKey: String, Hashable, StyleKey {

        // Keys used for `Item`.
        case title
        case content
        case label
        case value
        case cta
        case indicator

        static func key(for item: SnapStyle.Item.ItemType) -> SnapStyle.FontKey {
            switch item {
                case .any: .content // TODO: Is there a better default?
                    
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

    internal func font(for key: FontKey, in context: SnapStyle.Context) -> Font? {

        guard let values = fonts[key] else {
            return nil
        }

        let value = values.value(for: context)

        switch value {
            case .reference(let key): return font(for: key, in: context)
            default: return value?.wrappedValue
        }
        
    }

}
