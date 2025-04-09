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
    public var light3: ValueBuilder { .base(.definition(.value(Color.init(white: 0.6)))) }
    public var onLight0: ValueBuilder { .base(.definition(.value(Color.black))) }
    public var onLight1: ValueBuilder { .base(.definition(.value(Color.gray))) }
    public var onLight2: ValueBuilder { .base(.definition(.value(Color.gray))) }
    
    public var dark0: ValueBuilder { .base(.definition(.value(Color.black))) }
    public var dark1: ValueBuilder { .base(.definition(.value(Color.init(white: 0.2)))) }
    public var dark2: ValueBuilder { .base(.definition(.value(Color.init(white: 0.35)))) }
    public var dark3: ValueBuilder { .base(.definition(.value(Color.init(white: 0.45)))) }
    public var onDark0: ValueBuilder { .base(.definition(.value(Color.white))) }
    public var onDark1: ValueBuilder { .base(.definition(.value(Color.gray))) }
    public var onDark2: ValueBuilder { .base(.definition(.value(Color.gray))) }

    
    // MARK: - Accents
    
    // TODO: accent color could be a set?
    // Normal, Disabled, Highlighted, Selected
    // Main, Alternative, Contrast
    public var accent: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .disabled: .reference(\.onLight2) // TODO: Proper disabled color

                default: .reference(context.component.useAlternativeAccent ? \.accentAlt : \.accent0)
            }
        }
    }
    
    public var accent0: ValueBuilder { .base(.definition(.value(Color.accentColor))) }
    // TODO: Modify other key. .reference(\.key, modified: ...)
    public var accent1: ValueBuilder { .base(.definition(.value(Color.accentColor.mix(with: .black, by: 0.2)))) }
    public var accent2: ValueBuilder { .base(.definition(.value(Color.accentColor.mix(with: .black, by: 0.4)))) }
    public var onAccent: ValueBuilder { .base(.reference(\.onDark0)) }

    public var accentOverlay: ValueBuilder {
        .builder { context in
            if context.component.useAlternativeAccent { // TODO: Naming does not fit here. Just checks if is on context.
                 .definition(.value(Color.accentColor.mix(with: .black, by: 0.5).opacity(0.3)))
            } else {
                .definition(.value(Color.accentColor.opacity(0.3)))
            }
        }
    }

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
    
    public var content0: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.light0)
            case .dark: .reference(\.dark1)
            default: nil
        }
    }}
    
    public var content1: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.light1)
            case .dark: .reference(\.dark2)
            default: nil
        }
    }}
    
    public var content2: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.light2)
            case .dark: .reference(\.dark3)
            default: nil
        }
    }}
    
    public var onContent0: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.onLight0)
            case .dark: .reference(\.onDark0)
            default: nil
        }
    }}
    
    public var onContent1: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.onLight1)
            case .dark: .reference(\.onDark1)
            default: nil
        }
    }}
    
    public var onContent2: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.onLight2)
            case .dark: .reference(\.onDark2)
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
