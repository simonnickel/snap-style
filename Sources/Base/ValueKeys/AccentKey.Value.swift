//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI // TODO: Remove as soon as Accent no longer uses Color.

extension SnapStyle {
    public struct AccentKey: StyleKey { public init() {} }
}

extension SnapStyle.AccentKey {


    // MARK: - NumberKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Accent
        public typealias Adjustment = SnapStyle.AccentKey.Adjustment

        case value(WrappedValue)

        public var wrappedValue: WrappedValue {
            switch self {
                case .value(let value): value
            }
        }

        public var description: String {
            switch self {
                case .value(let value): ".value: \(value)"
            }
        }
        
        
        // MARK: - Accent
        
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


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.AccentKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
