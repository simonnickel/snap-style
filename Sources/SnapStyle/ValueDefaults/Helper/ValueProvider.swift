//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

protocol ValueProvider {
    
    associatedtype Key: StyleKey
    associatedtype Value
    
    static func values(for key: Key) -> SnapStyle.ValueBuilder<Value>

}

extension ValueProvider {
    
    static var defaultValues: [Key : SnapStyle.ValueBuilder<Value>] {
        var entries: [Key : SnapStyle.ValueBuilder<Value>] = [:]
        for key in Key.allCases {
            entries[key] = values(for: key)
        }
        return entries
    }
    
}
