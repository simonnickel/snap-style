//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public enum ValueBuilder<Value> {
        
        public typealias Builder = (Context) -> Value?
                
        case base(Value)
        case baseAnd(Value, context: Builder?)
        case context(Builder?)
        
        func value(in context: Context?) -> Value? {
            return switch self {
                    
                case .base(let value): value
                    
                case .baseAnd(let value, let builder):
                    if let context {
                        builder?(context) ?? value
                    } else {
                        value
                    }
                    
                case .context(let builder):
                    if let context {
                        builder?(context)
                    } else {
                        nil
                    }
                    
            }
        }

    }

}

