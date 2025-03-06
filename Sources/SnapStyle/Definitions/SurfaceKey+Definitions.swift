//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.SurfaceKey {
    
    // TODO: Highlighted states
    // TODO: Gradients
    // TODO: Materials

    
    // MARK: - Component
    
    public var anyContainer: ValueBuilder { .base(nil) }
    
    public var screen: ValueBuilder {
        .builder { context in
            .definition(.surface(.with(
                foreground: nil,
                background: \.screen,
                ignoresSafeAreaEdges: .all // Background of screen should ignore .vertical safe area to stretch beyond \.`widthReadableContent`.
            )))
        }
    }
    
    public var content: ValueBuilder {
        .builder { context in
            .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
            // TODO: How to define hierarchy of components?
//            switch context.component.hierarchy {
//                case .any, .primary: .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
//                case .secondary: .definition(.surface(.with(foreground: \.onContent0, background: \.content1)))
//            }
        }
    }

    public var list: ValueBuilder { .base(.reference(\.content)) }
    
    public var card: ValueBuilder {
        .builder { context in
            .definition(.surface(.with(foreground: \.onAccent, background: \.accent0)))
            // TODO: How to define hierarchy of components?
//            switch context.component.hierarchy {
//                case .any, .primary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent0)))
//                case .secondary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent1)))
//            }
        }
    }
    
    public var action: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .any, .primary:
                    if context.isHighlighted {
                        .definition(.surface(.with(foreground: \.onAccent, background: \.accent1)))
                    } else {
                        .definition(.surface(.with(foreground: \.onAccent, background: \.accent0)))
                    }
                case .secondary, .tertiary:
                    if context.isHighlighted {
                        .definition(.surface(.with(foreground: \.accent0, background: \.content1)))
                    } else {
                        .definition(.surface(.with(foreground: \.accent0, background: nil)))
                    }
            }
        }
    }
    

    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }
    
    public var title: ValueBuilder { .base(nil) }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }

    public var cta: ValueBuilder {
        .builder { context in
            .definition(.surface(.init(
                foreground: \.onAccent,
                background: \.accent0
            )))
        }
    }
    
    public var separator: ValueBuilder { .base(.definition(.surface(.with(foreground: \.onContent1)))) } // TODO: Better color definition
    
    
    // MARK: - States
    
    public var disabledContainer: ValueBuilder {
        .builder { context in
            .definition(.surface(.init(
                background: \.content1
            )))
        }
    }
    
    public var disabledElement: ValueBuilder {
        .builder { context in
            .definition(.surface(.init(
                foreground: \.onContent1
            )))
        }
    }
    
    public var highlightedContainer: ValueBuilder {
        .builder { context in
            .definition(.surface(.init(
                background: \.accentAlt
            )))
        }
    }
    
    public var highlightedElement: ValueBuilder {
        .builder { context in
            .definition(.surface(.init(
                foreground: \.accent0
            )))
        }
    }

}
