//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.SurfaceKey {
    
    
    // MARK: - Component
    
    public var card: ValueBuilder {
        .builder { context in
            switch context.component.hierarchy {
                case .any: .definition(.surface(.with(foreground: .white, background: .secondary))) // TODO: Reference a different color for foreground?
                case .primary: .definition(.surface(.with(foreground: .white, background: .secondary)))
                case .secondary: .definition(.surface(.with(foreground: .white, background: .primary)))
            }
        }
    }
    
 
    // MARK: - Element

    public var title: ValueBuilder { .base(.reference(\.content)) }

    public var content: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                return nil // Defined by \.card
            } else {
                return switch context.element.hierarchy {
                    case .any: .definition(.surface(.with(foreground: .primary)))
                    case .primary: .definition(.surface(.with(foreground: .primary)))
                    case .secondary: .definition(.surface(.with(foreground: .secondary)))
                    case .tertiary: .definition(.surface(.with(foreground: .secondary)))
                }
            }
        }
    }

    public var label: ValueBuilder { .base(.reference(\.content)) }

    public var icon: ValueBuilder { .base(.reference(\.label)) }
    
    public var value: ValueBuilder { .base(.reference(\.label)) }

    public var cta: ValueBuilder {
        .builder { context in
                .definition(.surface(.init(
                    foreground: Color.white,
                    background: Gradient(colors: [.blue, .yellow])
                )))
        }
    }

    public var indicator: ValueBuilder { .base(.reference(\.content)) }
    

    // MARK: - Highlight

    public var interactive: ValueBuilder { .base(.definition(.surface(.with(foreground: .accentColor)))) }

    public var navigation: ValueBuilder { .base(.reference(\.interactive)) }
    
}
