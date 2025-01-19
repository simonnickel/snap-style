//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.SurfaceKey {
    
    // TODO: Highlighted states
    // TODO: Gradients
    
    public var any: ValueBuilder { .base(nil) }

    
    // MARK: - Component
    
    public var screen: ValueBuilder { .base(.definition(.surface(.with(background: \.screen)))) }
    
    public var content: ValueBuilder { .base(.definition(.surface(.with(foreground: \.onContent, background: \.content)))) }
    
    public var list: ValueBuilder { .base(.reference(\.content)) }
    
    public var card: ValueBuilder {
        .builder { context in
            switch context.component.hierarchy {
                case .any, .primary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent0)))
                case .secondary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent1)))
            }
        }
    }
    
 
    // MARK: - Element

    public var title: ValueBuilder { .base(nil) }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }

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
