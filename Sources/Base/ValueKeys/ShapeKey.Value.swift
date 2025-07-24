//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI

extension SnapStyle {
    public struct ShapeKey: StyleKey { public init() {} }
}

extension SnapStyle.ShapeKey {
    
    
    // MARK: - ShapeKey.Value
    
    public enum Value: StyleValue {
        
        public typealias WrappedValue = ShapeDefinition
        public typealias Adjustment = SnapStyle.ShapeKey.Adjustment

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
    
    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = SnapStyle.ShapeKey.Value
        
        public func applied(on value: Value) -> Value {
            value
        }
        
    }


    // MARK: - Shape
    
    public enum ShapeDefinition: Equatable, CustomStringConvertible {
        
        case containerRelative
        case circle
        case capsule
        case rectangle
        case rectangleRounded(radius: SnapStyle.NumberKey.ValueBuilderKeyPath)


        public func shape(with style: SnapStyle.ContextWrapper) -> any InsettableShape {
            switch self {

                case .containerRelative: Rectangle()

                case .circle: Circle()

                case .capsule: Capsule()

                case .rectangle: Rectangle()

                case .rectangleRounded(radius: let numberKey):
                    if let cornerRadius = style.number(for: numberKey) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                    } else {
                        Rectangle()
                    }

            }
        }
        
        public var description: String {
            switch self {
                case .containerRelative: "ContainerRelative"
                case .circle: "Circle"
                case .capsule: "Capsule"
                case .rectangle: "Rectangle"
                case .rectangleRounded(radius: let radius): "RectangleRounded, radius: \(radius)"
            }
        }
        
    }
    
    
}
