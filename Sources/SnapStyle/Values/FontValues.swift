//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

class FontValues: DefaultValues {
    
    typealias Key = SnapStyle.FontKey
    typealias Value = Key.Value
    typealias ValuesForContext = SnapStyle.ValuesForContext<Key.Value>
    
    static func values(for key: Key) -> ValuesForContext {
        switch key {
                
            case .fallback: ValuesForContext(
                base: .definition(.init(size: 1))
            )
                
            case .title: ValuesForContext(
                base: .definition(.init(size: 18)),
                values: [
                    .card: .reference(.label),
                ]
            )
                
            case .label: ValuesForContext(
                base: .font(.body)
            )
                
            case .block: ValuesForContext(
                base: .reference(.label)
            )
                
            case .value: ValuesForContext(
                base: .reference(.label)
            )
                
            case .note: ValuesForContext(
                base: .reference(.label)
            )

            case .cta: ValuesForContext(
                base: .reference(.title)
            )
                
            case .icon: ValuesForContext(
                base: .reference(.label)
            )
                
            case .indicator: ValuesForContext(
                base: .reference(.label)
            )
                
        }
    }
    
}
