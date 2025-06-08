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

        public typealias WrappedValue = Definition
        public typealias Adjustment = SnapStyle.FontKey.Adjustment

        case with(
            size: CGFloat,
            weight: Font.Weight = .regular,
            textStyle: Font.TextStyle = .body
        )

        public var wrappedValue: WrappedValue {
            switch self {
                case .with(let size, let weight, let textStyle):
                    Definition(size: size, weight: weight, textStyle: textStyle)
            }
        }

        public var description: String {
            ".definition: \(wrappedValue)"
        }


        // MARK: Definition

        public struct Definition: CustomStringConvertible {

            package let size: CGFloat
            package let weight: Font.Weight
            package let textStyle: Font.TextStyle

            public init(size: CGFloat, weight: Font.Weight, textStyle: Font.TextStyle) {
                self.size = size
                self.weight = weight
                self.textStyle = textStyle
            }

            public var description: String { "size: \(size), weight: \(weight), textStyle: \(textStyle)" }

        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.FontKey.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
