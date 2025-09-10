//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style {
    public struct FontKey: StyleKey { public init() {} }
}

extension Style.FontKey {


    // MARK: - FontKey.Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Definition
        public typealias Adjustment = Style.FontKey.Adjustment

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
                    Definition(size: size, weight: weight, width: width, design: design, textStyle: textStyle)
            }
        }

        public var description: String {
            ".definition: \(wrappedValue)"
        }


        // MARK: Definition

        public struct Definition: CustomStringConvertible {

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

            public var description: String { "size: \(size), weight: \(weight), width: \(width), design: \(design), textStyle: \(textStyle)" }

        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = Style.FontKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
