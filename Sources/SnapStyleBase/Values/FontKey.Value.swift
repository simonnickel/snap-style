//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct FontKey: StyleKey { public init() {} }
}

extension SnapStyle.FontKey {
    
    
    // MARK: - FontKey.Value
    
    public enum Value: StyleValue {
        
        public typealias WrappedValue = Font
        
        case with(size: CGFloat)
        case font(Font)

        public var wrappedValue: WrappedValue {
            switch self {
                case .with(size: let size): Definition(size: size).font
                case .font(let font): font
            }
        }
        
        public var description: String {
            switch self {
                case .with(size: let size): ".definition: \(Definition(size: size))"
                case .font(let font): ".font"
            }
        }
        
        
        // MARK: - Definition
        
        public struct Definition: CustomStringConvertible {
            
            let size: CGFloat
            
            public init(size: CGFloat) {
                self.size = size
            }
            
            var font: Font {
                Font.system(size: size)
            }
            
            public var description: String { "size: \(size)" }
            
        }
    
    }
    
}
