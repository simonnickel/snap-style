//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.SurfaceKey {
    
    
    // MARK: - Generic Surfaces

    public var clear: ValueBuilder { .base(.definition(.color(.clear))) }

    public var light0: ValueBuilder { .base(.definition(.color(.white))) }
    public var light1: ValueBuilder { .base(.definition(.color(.init(white: 0.85)))) }
    public var light2: ValueBuilder { .base(.definition(.color(.init(white: 0.7)))) }
    public var light3: ValueBuilder { .base(.definition(.color(.init(white: 0.6)))) }
    public var onLight0: ValueBuilder { .base(.definition(.color(.black))) }
    public var onLight1: ValueBuilder { .base(.definition(.color(.gray))) }
    public var onLight2: ValueBuilder { .base(.definition(.color(.gray))) }
    
    public var dark0: ValueBuilder { .base(.definition(.color(.black))) }
    public var dark1: ValueBuilder { .base(.definition(.color(.init(white: 0.2)))) }
    public var dark2: ValueBuilder { .base(.definition(.color(.init(white: 0.35)))) }
    public var dark3: ValueBuilder { .base(.definition(.color(.init(white: 0.45)))) }
    public var onDark0: ValueBuilder { .base(.definition(.color(.white))) }
    public var onDark1: ValueBuilder { .base(.definition(.color(.gray))) }
    public var onDark2: ValueBuilder { .base(.definition(.color(.gray))) }

    public var disabled: ValueBuilder { .base(.definition(.color(.gray))) }
    public var onDisabled: ValueBuilder { .base(.reference(\.onDark0)) }

    
    // MARK: - Accents

    public var accent: ValueBuilder {
        .builder { context in
            .definition(.color(context.accent.base))
        }
    }
    public var accentComplementary: ValueBuilder {
        .builder { context in
            .definition(.color(context.accent.complementary))
        }
    }
    public var accentContrast: ValueBuilder {
        .builder { context in
            .definition(.color(context.accent.contrast))
        }
    }
    public var accentLevel2: ValueBuilder { .base(.reference(\.accent, adjustments: [.mix(.black, 0.2)])) }
    public var accentLevel3: ValueBuilder { .base(.reference(\.accent, adjustments: [.mix(.black, 0.4)])) }

    public var onAccent: ValueBuilder {
        .builder { context in
            switch context.accent.brightness {
                case .dark: .reference(\.onDark0)
                case .light: .reference(\.onLight0)
            }
        }
    }


    // MARK: Interactive

    public var interactive: ValueBuilder { .base(.reference(\.accent)) }
    public var onInteractive: ValueBuilder { .base(.reference(\.onAccent)) }
    
    
    // MARK: Overlay
    
    public var interactionStateOverlay: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .normal, .disabled: nil
                case .highlighted: .definition(.color(.black.opacity(0.2)))
                case .selected: .definition(.color(.black.opacity(0.3)))
            }
        }
    }
    public var interactionStateOverlayAccent: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .normal, .disabled: nil
                case .highlighted: .reference(\.accent, adjustments: [.opacity(0.2)])
                case .selected: .reference(\.accent, adjustments: [.opacity(0.3)])
            }
        }
    }
    

    // MARK: - Components
    
    public var screen: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .definition(.color(Color(red: 242/255, green: 242/255, blue: 242/247)))
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
