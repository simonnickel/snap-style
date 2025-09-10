//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension Style.Keys.Surface {


    // MARK: - Generic Surfaces

    public var none: ValueBuilder { .base(.none) }
    public var clear: ValueBuilder { .base(.definition(.color(.clear))) }

    public var light0: ValueBuilder { .base(.definition(.color(.white))) }
    public var light1: ValueBuilder { .base(.definition(.color(.init(white: 0.85)))) }
    public var light2: ValueBuilder { .base(.definition(.color(.init(white: 0.7)))) }
    public var light3: ValueBuilder { .base(.definition(.color(.init(white: 0.6)))) }
    public var onLight0: ValueBuilder { .base(.definition(.color(.black))) }
    public var onLight1: ValueBuilder { .base(.definition(.color(.gray))) }
    public var onLight2: ValueBuilder { .base(.definition(.color(.gray))) }

    public var dark0: ValueBuilder { .base(.definition(.color(.black))) }
    public var dark1: ValueBuilder { .base(.definition(.color(Color(red: 28/255, green: 28/255, blue: 30/255)))) }
    public var dark2: ValueBuilder { .base(.definition(.color(.init(white: 0.35)))) }
    public var dark3: ValueBuilder { .base(.definition(.color(.init(white: 0.45)))) }
    public var onDark0: ValueBuilder { .base(.definition(.color(.white))) }
    public var onDark1: ValueBuilder { .base(.definition(.color(.gray))) }
    public var onDark2: ValueBuilder { .base(.definition(.color(.gray))) }

    public var disabled: ValueBuilder { .base(.definition(.color(.gray))) }
    public var onDisabled: ValueBuilder { .base(.reference(\.onDark0)) }


    // MARK: - Accents

    public var accent: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accent.base)
        }
    }
    public var accentComplementary: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accent.complementary)
        }
    }

    public var accentContrast: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accent.contrast)
        }
    }

    public var accentBackground: ValueBuilder {
        .builder { context in
            switch context.component.level {
                case 1: .reference(\.accentLevel1)
                case 2: .reference(\.accentLevel2)
                case 3: .reference(\.accentLevel3)
                default: nil
            }
        }
    }

    public var accentLevel1: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accentPrimary.base)
        }
    }

    public var accentLevel2: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accentPrimary.base, adjustments: [.mix(.black, 0.2)])
        }
    }

    public var accentLevel3: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accentPrimary.base, adjustments: [.mix(.black, 0.4)])
        }
    }

    public var onAccent: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accent.onAccent)
        }
    }

    public var accentAsForeground: ValueBuilder {
        .builderWrapper { context in
            .reference(context.accent.base)
        }
    }

    public var accentGradientSoft: ValueBuilder {
        .builderWrapper { context in
            let accentBase = context.accentPrimary.base
            let accentComplementary = context.accentPrimary.complementary
            let accentContrast = context.accentPrimary.contrast
            
            let base = context.surface(for: accentBase)?.resolvedColor ?? .clear
            let complementary = context.surface(for: accentComplementary)?.resolvedColor ?? .clear
            let contrast = context.surface(for: accentContrast)?.resolvedColor ?? .clear
            
            return .definition(.any(AnyShapeStyle(
                MeshGradient(width: 4, height: 4, points: [
                    [0, 0], [0.33, 0], [0.66, 0], [1, 0],
                    [0, 0.33], [0.33, 0.33], [0.66, 0.33], [1, 0.33],
                    [0, 0.66], [0.33, 0.66], [0.66, 0.66], [1, 0.66],
                    [0, 1], [0.33, 1], [0.66, 1], [1, 1],
                ], colors: [
                    complementary, complementary, base, complementary,
                    base, complementary, complementary, base,
                    complementary, complementary, complementary, base,
                    complementary, complementary, base, base,
                ])
            )))
        }
    }
    
    public var accentGradientStrong: ValueBuilder {
        .builderWrapper { context in
            let accentBase = context.accentPrimary.base
            let accentComplementary = context.accentPrimary.complementary
            let accentContrast = context.accentPrimary.contrast
            
            let base = context.surface(for: accentBase)?.resolvedColor ?? .clear
            let complementary = context.surface(for: accentComplementary)?.resolvedColor ?? .clear
            let contrast = context.surface(for: accentContrast)?.resolvedColor ?? .clear
            
            return .definition(.any(AnyShapeStyle(
                MeshGradient(width: 3, height: 3, points: [
                    [0, 0], [0.66, 0], [1, 0],
                    [0, 0.33], [0.33, 0.33], [1, 0.33],
                    [0, 1], [0.33, 1], [1, 1],
                ], colors: [
                    contrast, contrast, base,
                    base, contrast, base,
                    contrast, base, contrast,
                ])
            )))
        }
    }


    // MARK: Interactive

    public var interactive: ValueBuilder { .base(.reference(\.accent)) }

    public var onInteractive: ValueBuilder { .base(.reference(\.onAccent)) }

    public var interactiveAsForeground: ValueBuilder { .base(.reference(\.accentAsForeground)) }

    
    // MARK: Overlay
    
    public var stateOverlayOnAccent: ValueBuilder {
        .builderWrapper { context in
            let brightness = context.accent.brightness

            return switch context.context.component.state {
                case .normal, .disabled: .reference(\.clear)
                case .highlighted: brightness == .light ? .definition(.color(.black.opacity(0.2))) :  .definition(.color(.white.opacity(0.2)))
                case .selected: brightness == .light ? .definition(.color(.black.opacity(0.3))) : .definition(.color(.white.opacity(0.3)))
            }
        }
    }
    
    public var stateOverlayOnInteractive: ValueBuilder {
        .builder { context in
            .reference(\.stateOverlayOnAccent)
        }
    }

    public var stateOverlayAccented: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .normal, .disabled: .reference(\.clear)
                case .highlighted: .reference(\.accent, adjustments: [.opacity(0.2)])
                case .selected: .reference(\.accent, adjustments: [.opacity(0.3)])
            }
        }
    }
    
    
    // MARK: - Elements
    
    public var indicatorNavigation: ValueBuilder { .builder { context in
        switch context.colorScheme {
            // TODO: Should it fit system?
            case .light: .reference(\.onLight1)
            case .dark: .reference(\.onDark1)
            default: nil
        }
    }}


    // MARK: - Components
    
    public var screen: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .definition(.color(Color(red: 242/255, green: 242/255, blue: 247/255)))
            case .dark: .reference(\.dark0)
            default: nil
        }
    }}


    // MARK: Content

    public var contentBackground: ValueBuilder {
        .builder { context in
            switch context.component.level {
                case 1: .reference(\.contentLevel1)
                case 2: .reference(\.contentLevel2)
                case 3: .reference(\.contentLevel3)
                default: nil
            }
        }
    }

    public var contentLevel1: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.light0)
            case .dark: .reference(\.dark1)
            default: nil
        }
    }}
    
    public var contentLevel2: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.light1)
            case .dark: .reference(\.dark2)
            default: nil
        }
    }}
    
    public var contentLevel3: ValueBuilder { .builder { context in
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
    
    public var onContentDisabled: ValueBuilder { .builder { context in
        switch context.colorScheme {
            case .light: .reference(\.onLight1)
            case .dark: .reference(\.onDark1)
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
    
    
    // MARK: - Colors
    
    public var systemAccent: ValueBuilder {
        .base(.definition(.color(.accentColor)))
    }
    
    public var systemAccentComplementary: ValueBuilder {
        .base(.reference(\.systemAccent, adjustments: [.mix(.white, 0.2)]))
    }
    
    public var systemAccentContrast: ValueBuilder {
        .base(.reference(\.systemAccent, adjustments: [.mix(.black, 0.2)]))
    }
    
    public var snapBlack: ValueBuilder {
        .base(.definition(.color(.black)))
    }
    
    public var snapWhite: ValueBuilder {
        .base(.definition(.color(.white)))
    }
    
    public var snapGray: ValueBuilder {
        .base(.definition(.color(.gray)))
    }
    
    public var snapBlue: ValueBuilder {
        .base(.definition(.color(.blue)))
    }
    
    public var snapIndigo: ValueBuilder {
        .base(.definition(.color(.indigo)))
    }
    
    public var snapPurple: ValueBuilder {
        .base(.definition(.color(.purple)))
    }
    
    public var snapRed: ValueBuilder {
        .base(.definition(.color(.red)))
    }
    
    public var snapOrange: ValueBuilder {
        .base(.definition(.color(.orange)))
    }
    
    public var snapYellow: ValueBuilder {
        .base(.definition(.color(.yellow)))
    }
    
    public var snapPink: ValueBuilder {
        .base(.definition(.color(.pink)))
    }
    
    public var snapGreen: ValueBuilder {
        .base(.definition(.color(.green)))
    }
    
    public var snapCyan: ValueBuilder {
        .base(.definition(.color(.cyan)))
    }
    
    public var snapTeal: ValueBuilder {
        .base(.definition(.color(.teal)))
    }
    
    public var snapMint: ValueBuilder {
        .base(.definition(.color(.mint)))
    }
    
    public var snapBrown: ValueBuilder {
        .base(.definition(.color(.brown)))
    }
    
}
