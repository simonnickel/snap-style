//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

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
        
        static func isErase(_ value: Value) -> Bool {
            if case .erase = value { return true }
            return false
        }

    }
    
}
