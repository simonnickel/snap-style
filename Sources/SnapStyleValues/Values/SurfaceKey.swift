//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

extension SnapStyle {
    
    public struct SurfaceKey: StyleKey {
        
        public init() {}
        
        public typealias ValueBuilder = SnapStyle.ValueBuilder<Value>
        public typealias ValueKeyPath = KeyPath<Self, ValueBuilder>
        
        internal static var defaultKeyPaths: [ValueKeyPath] {
            return [\.title, \.content, \.label, \.value, \.cta, \.indicator, \.interactive, \.navigation]
        }
        
        public static func isErase(_ value: Value) -> Bool {
            if case .erase = value { return true }
            return false
        }
        
    }
    
}
