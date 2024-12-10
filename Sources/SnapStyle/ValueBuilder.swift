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

    }

}

