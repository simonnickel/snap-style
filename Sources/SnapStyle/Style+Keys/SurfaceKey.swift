//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public struct SurfaceKey: StyleKey {
        
        public typealias ValueBuilder = SnapStyle.ValueBuilder<Value>
        public typealias ValueKeyPath = KeyPath<Self, ValueBuilder>
        

        // MARK: - Item

        public let title = ValueBuilder(.surface(.init(foreground: .mint)))

        public let content = ValueBuilder { context in
            switch context.item.hierarchy {
                case .primary: .surface(.init(foreground: Color.primary))
                case .secondary: .surface(.init(foreground: Color.secondary))
                case .tertiary: .surface(.init(foreground: Color.secondary))
            }
        }

        public let label = ValueBuilder(.reference(\.content))

        public let value = ValueBuilder(.reference(\.interactive))

        public let cta = ValueBuilder { context in
            .surface(.init(
                foreground: .white,
                background: Gradient(colors: [.blue, .yellow])
            ))
        }

        public let indicator = ValueBuilder(.reference(\.content))
        

        // MARK: - Highlight

        public let interactive = ValueBuilder(.surface(.init(foreground: Color.accentColor)))

        public let navigation = ValueBuilder(.reference(\.interactive))
        
        
        internal static var defaultKeyPaths: [ValueKeyPath] {
            return [\.title, \.content, \.label, \.value, \.cta, \.indicator, \.interactive, \.navigation]
        }

        internal static func keyPath(for item: SnapStyle.Item.ItemType) -> ValueKeyPath {
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
        
        internal static func isErase(_ value: Value) -> Bool {
            if case .erase = value { return true }
            return false
        }
        
    }
    
}
