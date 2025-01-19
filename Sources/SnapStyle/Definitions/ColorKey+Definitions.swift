//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.ColorKey {
    
    
    // MARK: - Generic Colors

    public var light0: ValueBuilder { .base(.definition(.value(Color.white))) }
    public var light1: ValueBuilder { .base(.definition(.value(Color.init(white: 0.85)))) }
    public var light2: ValueBuilder { .base(.definition(.value(Color.init(white: 0.7)))) }
    public var onLight0: ValueBuilder { .base(.definition(.value(Color.black))) }
    
    public var dark0: ValueBuilder { .base(.definition(.value(Color.black))) }
    public var dark1: ValueBuilder { .base(.definition(.value(Color.init(white: 0.2)))) }
    public var dark2: ValueBuilder { .base(.definition(.value(Color.init(white: 0.35)))) }
    public var onDark0: ValueBuilder { .base(.definition(.value(Color.white))) }
    
    
    // MARK: - Accents
    
    public var accent0: ValueBuilder { .base(.definition(.value(Color.accentColor))) }
    public var accent1: ValueBuilder { .base(.definition(.value(Color.accentColor.mix(with: .black, by: 0.2)))) } // TODO: Modify other key. .reference(\.key, modified: ...)
    public var onAccent: ValueBuilder { .base(.reference(\.onDark0)) }

    public var accentAlt: ValueBuilder { .base(.definition(.value(Color.mint))) } // TODO: Modified accent
    public var onAccentAlt: ValueBuilder { .base(.reference(\.onDark0)) }
    
    
    // MARK: - Components
    
    public var screen: ValueBuilder { .builder { context in
        switch context.colorScheme {
                
            case .light: .reference(\.light1)
                    
            case .dark: .reference(\.dark0)
                
            default: nil
        }
    }}
    
    public var content: ValueBuilder { .builder { context in
        switch context.colorScheme {
                
            case .light: switch context.component.hierarchy {
                case .any, .primary: .reference(\.light0)
                case .secondary: .reference(\.light1)
            }
                    
            case .dark: switch context.component.hierarchy {
                case .any, .primary: .reference(\.dark1)
                case .secondary: .reference(\.dark2)
            }
                
            default: nil
        }
    }}
    
    public var onContent: ValueBuilder { .builder { context in
        switch context.colorScheme {
                
            case .light: .reference(\.onLight0)
            case .dark: .reference(\.onDark0)
                
            default: nil
        }
    }}
    
//    public var text: ValueBuilder {
//        .base(.definition(.value(.primary))) { context in
//            switch context.element.hierarchy {
//                case .any: .definition(.value(.primary))
//                case .primary: .definition(.value(.primary))
//                case .secondary: .definition(.value(.secondary))
//                case .tertiary: .definition(.value(.secondary))
//            }
//        }
//    }
    
}
