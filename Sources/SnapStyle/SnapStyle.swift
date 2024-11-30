//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    let fonts: [FontKey : ValuesForContext<FontKey.Value>]
    
    public init() {
        fonts = DefaultValues.defaultFonts
    }
    
    
    // MARK: - Get
    
    func font(for key: FontKey, in context: Context) -> Font {
        guard let value = fonts[key]?.value(in: context) else {
            return fonts[.fallback]?.value(in: context).font ?? DefaultValues.values(for: FontKey.fallback).value(in: context).font
        }
        
        return switch value {
            case .reference(let fontKey): font(for: fontKey, in: context)
            default: value.font
        }
    }
    
}
