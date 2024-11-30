//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


extension SnapStyle.DefaultValues {
    
    typealias ColorKey = SnapStyle.ColorKey
    typealias ColorValuesForContext = SnapStyle.ValuesForContext<ColorKey.Value>
    
    static var defaultColors: [ColorKey : ColorValuesForContext] {
        var entries: [ColorKey : ColorValuesForContext] = [:]
        for key in ColorKey.allCases {
            entries[key] = values(for: key)
        }
        return entries
    }
    
    static func values(for key: ColorKey) -> ColorValuesForContext {
        switch key {
                
            case .fallback: ColorValuesForContext(
                base: .color(.pink)
            )
                
            case .highlight: ColorValuesForContext(
                base: .color(.green)
            )
        }
    }
    
}
