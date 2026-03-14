//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.Attribute {
    public struct Font: StyleAttribute { public init() {} }
}

extension Style.Attribute.Font {


    // MARK: - Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Properties
        public typealias Adjustment = Style.Attribute.Font.Adjustment

        case with(
            size: CGFloat,
            weight: Font.Weight = .regular,
            width: Font.Width? = nil,
            design: Font.Design? = nil,
            textStyle: Font.TextStyle = .body
        )

        public var wrappedValue: WrappedValue {
            switch self {
                case .with(let size, let weight, let width, let design, let textStyle):
                    Properties(size: size, weight: weight, width: width, design: design, textStyle: textStyle)
            }
        }

        public var description: String {
            ".definition: \(wrappedValue)"
        }


        // MARK: Properties

        public struct Properties: CustomStringConvertible {

            package let size: CGFloat
            package let weight: Font.Weight
            package let width: Font.Width?
            package let design: Font.Design?
            package let textStyle: Font.TextStyle

            public init(
                size: CGFloat,
                weight: Font.Weight,
                width: Font.Width? = nil,
                design: Font.Design? = nil,
                textStyle: Font.TextStyle
            ) {
                self.size = size
                self.weight = weight
                self.width = width
                self.design = design
                self.textStyle = textStyle
            }

            public var description: String { "size: \(size), weight: \(weight), width: \(width, default: "-"), design: \(design, default: "-"), textStyle: \(textStyle)" }

        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = Style.Attribute.Font.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
