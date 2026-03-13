//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.Attribute {
    public struct Padding: StyleAttribute { public init() {} }
}

extension Style.Attribute.Padding {


    // MARK: - Value

    public enum Value: StyleValue {

        public typealias WrappedValue = Properties
        public typealias Adjustment = Style.Attribute.Padding.Adjustment

        case all(Properties.Value)
        case edges(_ edges: Edge.Set, value: Properties.Value)
        case edge(leading: Properties.Value?, top: Properties.Value?, trailing: Properties.Value?, bottom: Properties.Value?)
        case horizontal(Properties.Value)
        case vertical(Properties.Value)
        case axis(horizontal: Properties.Value, vertical: Properties.Value)

        public var wrappedValue: WrappedValue {
            switch self {
                case .all(let value): Properties(value)
                case let .edges(edges, value: value): Properties(value, edges: edges)
                case let .edge(leading: leading, top: top, trailing: trailing, bottom: bottom): Properties(leading: leading, top: top, trailing: trailing, bottom: bottom)
                case let .horizontal(value): Properties(horizontal: value, vertical: nil)
                case let .vertical(value): Properties(horizontal: nil, vertical: value)
                case let .axis(horizontal: horizontal, vertical: vertical): Properties(horizontal: horizontal, vertical: vertical)
            }
        }

        public var description: String {
            wrappedValue.description
        }
        
        
        // MARK: Properties
        
        public struct Properties: CustomStringConvertible {

            public typealias Value = Style.Attribute.Number.ValueBuilderKeyPath

            package let leading: Value?
            package let top: Value?
            package let trailing: Value?
            package let bottom: Value?

            public init(_ value: Value, edges: Edge.Set = .all) {
                self.leading = edges.contains(.leading) ? value : nil
                self.top = edges.contains(.top) ? value : nil
                self.trailing = edges.contains(.trailing) ? value : nil
                self.bottom = edges.contains(.bottom) ? value : nil
            }

            public init(horizontal: Value? = nil, vertical: Value? = nil) {
                self.leading = horizontal
                self.top = vertical
                self.trailing = horizontal
                self.bottom = vertical
            }

            public init(leading: Value? = nil, top: Value? = nil, trailing: Value? = nil, bottom: Value? = nil) {
                self.leading = leading
                self.top = top
                self.trailing = trailing
                self.bottom = bottom
            }

            public var description: String {
                // TODO: Useful text representation
                ""
            }
            
        }

    }


    // MARK: - Adjustment

    public enum Adjustment: StyleAdjustment {

        public typealias Value = Style.Attribute.Padding.Value

        public func applied(on value: Value) -> Value {
            value
        }

    }

}
