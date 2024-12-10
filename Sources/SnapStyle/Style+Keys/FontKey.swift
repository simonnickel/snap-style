//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public struct FontKey: StyleKey {
        
        public init() {}
        
        public typealias ValueBuilder = SnapStyle.ValueBuilder<Value>
        public typealias ValueKeyPath = KeyPath<Self, ValueBuilder>
        
        public let title = ValueBuilder { context in
            switch context.item.hierarchy {
                case .primary: .definition(.init(size: 18))
                case .secondary: .definition(.init(size: 16))
                case .tertiary: .definition(.init(size: 14))
            }
        }
        
        public let label = ValueBuilder(.font(.body)) { context in
            switch context.component.type {
                case .card: .font(.caption)
                default: nil
            }
        }

        public let content = ValueBuilder(.reference(\.label))

        public let value = ValueBuilder(.reference(\.label))

        public let cta = ValueBuilder(.reference(\.label))

        public let indicator = ValueBuilder(.reference(\.label))

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
