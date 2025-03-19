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

    
    // MARK: - Component: Container
    
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
    
    public var containerContent: ValueBuilder {
        .builder { context in
            switch context.componentStack.level {
                case 1: .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
                case 2: .definition(.surface(.with(background: \.content1)))
                case 3: .definition(.surface(.with(background: \.content2)))
                default: nil
            }
        }
    }
    
    public var containerList: ValueBuilder {
        .base(.reference(\.containerContent))
    }
    
    public var containerCard: ValueBuilder {
        .builder { context in
            switch context.componentStack.level {
                case 1: .definition(.surface(.with(foreground: \.onAccent, background: \.accent)))
                case 2: .definition(.surface(.with(background: \.accent1)))
                case 3: .definition(.surface(.with(background: \.accent2)))
                default: nil
            }
        }
    }
    
    public var containerAction: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .any, .primary:
                    if context.isHighlighted {
                        .definition(.surface(.with(foreground: \.onAccent, background: \.accent))) // TODO: accent color should be a set
                    } else {
                        .definition(.surface(.with(foreground: \.onAccent, background: \.accent)))
                    }
                case .secondary, .tertiary:
                    if context.isHighlighted {
                        .definition(.surface(.with(foreground: \.accent, background: \.content1)))
                    } else {
                        .definition(.surface(.with(foreground: \.accent, background: nil)))
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
    
    public var separator: ValueBuilder { .base(.definition(.surface(.with(foreground: \.onContent1)))) } // TODO: Better color definition
    
    
    // TODO: Not sure if they make sense this way
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
