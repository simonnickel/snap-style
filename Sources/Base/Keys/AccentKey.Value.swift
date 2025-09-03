//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

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
        
        public struct Accent: Hashable, Equatable {
            
            public typealias ColorValue = SnapStyle.SurfaceKey.ValueBuilderKeyPath
            
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

        public typealias Value = SnapStyle.AccentKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
