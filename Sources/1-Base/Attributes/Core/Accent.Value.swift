//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Attribute {
    public struct Accent: StyleAttribute { public init() {} }
}

extension Style.Attribute.Accent {
    
    
    // MARK: - Value
    
    public struct Value: StyleValue, Hashable, Equatable {
        
        public typealias WrappedValue = Self
        public typealias Adjustment = Style.Attribute.Accent.Adjustment
        
        public typealias ColorValue = Style.Attribute.Surface.ValueBuilderKeyPath
        
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
        
        public var wrappedValue: WrappedValue { self }
        
        public var description: String {
            "\(self)" // TODO finetuning: Proper description
        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = Style.Attribute.Accent.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
