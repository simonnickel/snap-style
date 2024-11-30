//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


class ColorValues: DefaultValues {
    
    typealias Key = SnapStyle.ColorKey
    typealias Value = Key.Value
    typealias ValuesForContext = SnapStyle.ValuesForContext<Key.Value>
    
    static func values(for key: Key) -> ValuesForContext {
        switch key {
                
            case .fallback: ValuesForContext(
                base: .color(.pink)
            )
                
            case .highlight: ValuesForContext(
                base: .color(.green)
            )
        }
    }
    
}
