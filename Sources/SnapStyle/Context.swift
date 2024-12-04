//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {

    public enum Context {
        
        case header
        case main
        case card
        case list
        case sidebar
        case toolbar
        
        public enum State {
            
            case disabled
            case normal
            case interactive
            case navigative
            case highlighted
            case selected
            
        }

        
    }

    public struct ValuesForContext<Value> {
        private let base: Value
        private let values: [Context : Value]
        
        public init(base: Value, values: [SnapStyle.Context : Value] = [:]) {
            self.base = base
            self.values = values
        }
                
        func value(in context: Context) -> Value {
            values[context] ?? base
        }
    }
    
}
