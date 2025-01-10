//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public enum ValueBuilder<Value> {
        
        public typealias Builder = (Context) -> Value?
                
        case base(Value, builder: Builder? = nil)
        case builder(Builder?)
        
        func value(in context: Context?) -> Value? {
            return switch self {
                    
                case .base(let value, let builder):
                    if let context {
                        builder?(context) ?? value
                    } else {
                        value
                    }
                    
                case .builder(let builder):
                    if let context {
                        builder?(context)
                    } else {
                        nil
                    }
                    
            }
        }

    }

}

