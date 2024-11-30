//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

protocol DefaultValues {
    
    associatedtype Key: StyleKey
    associatedtype Value
    
    static func values(for key: Key) -> SnapStyle.ValuesForContext<Value>
    
}

extension DefaultValues {
    
    static var defaultValues: [Key : SnapStyle.ValuesForContext<Value>] {
        var entries: [Key : SnapStyle.ValuesForContext<Value>] = [:]
        for key in Key.allCases {
            entries[key] = values(for: key)
        }
        return entries
    }
    
}
