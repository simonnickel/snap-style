//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct FontKey: StyleKey {
        
        public init() {}
        
        public typealias ValueBuilder = SnapStyle.ValueBuilder<Value>
        public typealias ValueKeyPath = KeyPath<Self, ValueBuilder>
        
        internal static var defaultKeyPaths: [ValueKeyPath] {
            return [\.title, \.label, \.content, \.value, \.cta, \.indicator]
        }
        
        public static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath {
            switch item {
                case .any: \.content // TODO: Is there a better default?
                    
                case .title: \.title
                case .content: \.content
                case .label: \.label
                case .value: \.value
                case .cta: \.cta
                case .indicator: \.indicator
            }
        }

    }
    
}
