//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI

extension Style.Keys {
    public struct Shape: StyleKey { public init() {} }
}

extension Style.Keys.Shape {
    
    
    // MARK: - ShapeKey.Value
    
    public enum Value: StyleValue, Equatable {
        
        public typealias WrappedValue = Self
        public typealias Adjustment = Style.Keys.Shape.Adjustment
        
        case containerRelative
        case circle
        case capsule
        case rectangle
        case rectangleRounded(radius: Style.Keys.Number.ValueBuilderKeyPath)
        
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
                    if let cornerRadius = style.number(for: numberKey) { // TODO: Does it apply DynamicType scaling here (or in other non View contexts)?
                        RoundedRectangle(cornerRadius: cornerRadius)
                    } else {
                        Rectangle()
                    }
                    
            }
        }
        
    }
    
    
    // MARK: - Adjustment
    
    public enum Adjustment: StyleAdjustment {
        
        public typealias Value = Style.Keys.Shape.Value
        
        public func applied(on value: Value) -> Value {
            value
        }
        
    }
    
}
