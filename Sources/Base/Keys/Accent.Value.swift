//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Keys {
    public struct Accent: StyleKey { public init() {} }
}

extension Style.Keys.Accent {


    // MARK: - NumberKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Accent
        public typealias Adjustment = Style.Keys.Accent.Adjustment

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
        
        public struct Accent: Hashable, Equatable {
            
            public typealias ColorValue = Style.Keys.Surface.ValueBuilderKeyPath
            
            public let base: ColorValue
            public let onAccent: ColorValue
            public let complementary: ColorValue
            public let contrast: ColorValue
            public let brightness: Brightness

            public enum Brightness {
                case light, dark
            }

            public init(base: ColorValue, onAccent: ColorValue, complementary: ColorValue, contrast: ColorValue, brightness: Brightness) {
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

        public typealias Value = Style.Keys.Accent.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
