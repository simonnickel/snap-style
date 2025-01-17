//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.SurfaceKey {
    
    // TODO: Highlighted states
    // TODO: Gradients
    
    // MARK: - Component
    
    public var screen: ValueBuilder { .base(.definition(.surface(.with(background: \.screen)))) }
    
    public var contentComponent: ValueBuilder { .base(.definition(.surface(.with(foreground: \.onContent, background: \.content)))) }
    
    public var list: ValueBuilder { .base(.reference(\.contentComponent)) }
    
    public var card: ValueBuilder {
        .builder { context in
            switch context.component.hierarchy {
                case .any, .primary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent0)))
                case .secondary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent1)))
            }
        }
    }
    
 
    // MARK: - Element

    public var title: ValueBuilder { .base(.reference(\.content)) }

    // TODO: Rename Content element to not conflict with Component
    public var content: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                return nil // Defined by \.card
            } else {
                return switch context.element.hierarchy {
                    case .any, .primary: .definition(.surface(.with(foreground: \.onContent)))
                    case .secondary: .definition(.surface(.with(foreground: \.onContent)))
                    case .tertiary: .definition(.surface(.with(foreground: \.onContent)))
                }
            }
        }
    }

    public var label: ValueBuilder { .base(.reference(\.content)) }

    public var icon: ValueBuilder { .base(.reference(\.content)) }
    
    public var value: ValueBuilder { .base(.reference(\.content)) }

    public var cta: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                .definition(.surface(.init(
                    foreground: \.onAccentAlt,
                    background: \.accentAlt
                )))
            } else {
                .definition(.surface(.init(
                    foreground: \.onAccent,
                    background: \.accent0
                )))
            }
        }
    }
    
}
