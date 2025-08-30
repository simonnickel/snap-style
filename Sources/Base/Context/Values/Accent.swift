//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    // TODO: Could be moved to AccentKey.
    // TODO: Could hold ValueBuilderKeyPath instead of Color (see stash).
    public struct Accent: Hashable, Equatable {
        
        public let base: Color
        public let onAccent: Color
        public let complementary: Color
        public let contrast: Color
        public let brightness: Brightness

        public enum Brightness {
            case light, dark
        }

        public init(base: Color, onAccent: Color, complementary: Color, contrast: Color, brightness: Brightness) {
            self.base = base
            self.onAccent = onAccent
            self.complementary = complementary
            self.contrast = contrast
            self.brightness = brightness
        }

    }

}
