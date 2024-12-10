//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public struct SurfaceKey: StyleKey {
        
        public init() {}
        
        public typealias ValueBuilder = SnapStyle.ValueBuilder<Value>
        public typealias ValueKeyPath = KeyPath<Self, ValueBuilder>
        
        internal static var defaultKeyPaths: [ValueKeyPath] {
            return [\.title, \.content, \.label, \.value, \.cta, \.indicator, \.interactive, \.navigation]
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
        
        public static func isErase(_ value: Value) -> Bool {
            if case .erase = value { return true }
            return false
        }
        
    }
    
}
