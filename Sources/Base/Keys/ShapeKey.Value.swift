//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI

extension Style {
    public struct ShapeKey: StyleKey { public init() {} }
}

extension Style.ShapeKey {
    
    
    // MARK: - ShapeKey.Value
    
    public enum Value: StyleValue, Equatable {
        
        public typealias WrappedValue = Self
        public typealias Adjustment = Style.ShapeKey.Adjustment
        
        case containerRelative
        case circle
        case capsule
        case rectangle
        case rectangleRounded(radius: Style.NumberKey.ValueBuilderKeyPath)
        
        public var wrappedValue: WrappedValue {
            self
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
        
        public func shape(with style: Style.ContextWrapper) -> any InsettableShape {
            switch self {
                    
                case .containerRelative: ContainerRelativeShape()
                    
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
        
    }
    
    
    // MARK: - Adjustment
    
    public enum Adjustment: StyleAdjustment {
        
        public typealias Value = Style.ShapeKey.Value
        
        public func applied(on value: Value) -> Value {
            value
        }
        
    }
    
}
