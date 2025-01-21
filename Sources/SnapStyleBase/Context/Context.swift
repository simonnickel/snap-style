//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    
    // MARK: - Context

    public struct Context: Hashable {
        
        internal typealias Key = AnyHashable
        internal typealias Value = AnyHashable
        internal var content: [Key : Value] = [:]

        /// A context to use for default values.
        public static var any: SnapStyle.Context { .init() }
        
        
        // MARK: Attribute
        
        public struct Attribute<Key: Hashable, Value: Hashable> {
            let key: Key
            let valueDefault: Value?
            
            package init(key: Key, valueDefault: Value?) {
                self.key = key
                self.valueDefault = valueDefault
            }
        }
        
        package func withAttribute<Key: Hashable, Value: Hashable>(value: Value, for attribute: Attribute<Key, Value>) -> Self {
            var result = self
            result.content[attribute.key] = value
            return result
        }
        
        package func getValue<Key: Hashable, Value: Hashable>(for attribute: Attribute<Key, Value>) -> Value? {
            content[attribute.key] as? Value ?? attribute.valueDefault
        }
        
    }

}
