//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.DefaultValues {
    
    typealias FontKey = SnapStyle.FontKey
    typealias FontValuesForContext = SnapStyle.ValuesForContext<FontKey.Value>
    
    static var defaultFonts: [FontKey : FontValuesForContext] {
        var entries: [FontKey : FontValuesForContext] = [:]
        for key in FontKey.allCases {
            entries[key] = values(for: key)
        }
        return entries
    }
    
    static func values(for key: FontKey) -> FontValuesForContext {
        switch key {
                
            case .fallback: FontValuesForContext(
                base: .definition(.init(size: 1))
            )
                
            case .title: FontValuesForContext(
                base: .definition(.init(size: 18)),
                values: [
                    .card: .reference(.label),
                ]
            )
                
            case .subtitle: FontValuesForContext(
                base: .definition(.init(size: 16)),
                values: [
                    .card: .reference(.label),
                ]
            )
                
            case .label: FontValuesForContext(
                base: .font(.body)
            )
                
            case .block: FontValuesForContext(
                base: .reference(.label)
            )
                
            case .value: FontValuesForContext(
                base: .reference(.label)
            )
                
            case .note: FontValuesForContext(
                base: .reference(.label)
            )
                
            case .icon: FontValuesForContext(
                base: .reference(.label)
            )
                
            case .indicator: FontValuesForContext(
                base: .reference(.label)
            )
                
        }
    }
    
}
