//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    public struct ShapeKey: StyleKey { public init() {} }
}

extension SnapStyle.ShapeKey {
    
    
    // MARK: - ShapeKey.Value
    
    public enum Value: StyleValue {
        
        public typealias WrappedValue = StyleShape
        
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
    
    
    // MARK: - Shape
    
    public enum StyleShape: CustomStringConvertible {
        
        case capsule
        case rectangle(cornerRadius: SnapStyle.NumberKey.ValueBuilderKeyPath)
        
        public func insettableShape(for style: SnapStyle, in context: SnapStyle.Context) -> StyleInsettableShape {
            
            switch self {
                
                case .capsule: StyleInsettableShape { rect in
                    Capsule().path(in: rect)
                }
                    
                case .rectangle(cornerRadius: let numberKey):
                    if let cornerRadius = style.number(for: numberKey, in: context) {
                        StyleInsettableShape { rect in
                            RoundedRectangle(cornerRadius: cornerRadius).path(in: rect)
                        }
                    } else {
                        StyleInsettableShape { rect in
                            Rectangle().path(in: rect)
                        }
                    }
                    
            }
        }
        
        public var description: String {
            switch self {
                case .capsule: "Capsule"
                case .rectangle(cornerRadius: let cornerRadius): "Rectangle, cornerRadius: \(cornerRadius)"
            }
        }
        
    }
    
    /// A wrapper to provide an `InsettableShape` without relying on a SwiftUI defined `Shape`.
    public struct StyleInsettableShape: InsettableShape {
        
        private let base: @Sendable (CGRect) -> Path
        private let inset: CGFloat
        
        init(base: @Sendable @escaping (CGRect) -> Path, inset: CGFloat = 0) {
            self.base = base
            self.inset = inset
        }
        
        public func inset(by amount: CGFloat) -> Self {
            .init(base: base, inset: amount)
        }
        
        public func path(in rect: CGRect) -> Path {
            base(rect.inset(by: .init(top: inset, left: inset, bottom: inset, right: inset)))
        }
    }
    
}
