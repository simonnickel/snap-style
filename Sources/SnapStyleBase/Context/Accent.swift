//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public struct Accent: Hashable, Equatable {
        public let base: Color
        public let complementary: Color
        public let contrast: Color
        
        public init(base: Color, complementary: Color, contrast: Color) {
            self.base = base
            self.complementary = complementary
            self.contrast = contrast
        }
        
        public static var fallback: Self { Accent(base: Color.accentColor, complementary: Color.accentColor.mix(with: .white, by: 0.2), contrast: Color.accentColor.mix(with: .black, by: 0.2)) }
    }
    
}

extension SnapStyle.Context {
    
    public var accent: SnapStyle.Accent { getValue(for: Self.accent) ?? SnapStyle.Accent.fallback }
    
    public static var accent: Attribute<String, SnapStyle.Accent> { .init(key: "accent", valueDefault: SnapStyle.Accent.fallback) }
    
}
