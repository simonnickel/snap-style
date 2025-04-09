//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.SurfaceKey {
    
    // TODO: Gradients
    // TODO: Materials
    
    // MARK: - Generic Surfaces
    
    public var accentElement: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .highlighted: .definition(.surface(.with(foreground: \.accent, background: \.content1))) // TODO: Could be a transparent highlight instead of \.content1

                case .disabled: .definition(.surface(.with(foreground: \.accent, background: nil)))
                    
                default: .definition(.surface(.with(foreground: \.accent, background: nil)))
            }
        }
    }
    
    public var accentContainer: ValueBuilder {
        .builder { context in
            switch context.componentStack.level {
                case 1: .definition(.surface(.with(foreground: \.onAccent, background: \.accent)))
                case 2: .definition(.surface(.with(foreground: \.onAccent, background: \.accent1)))
                case 3: .definition(.surface(.with(foreground: \.onAccent, background: \.accent2)))
                default: nil
            }
        }
    }
    
    public var contentContainer: ValueBuilder {
        .builder { context in
            switch context.componentStack.level {
                case 1: .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
                case 2: .definition(.surface(.with(background: \.content1)))
                case 3: .definition(.surface(.with(background: \.content2)))
                default: nil
            }
        }
    }

    
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
        .base(.reference(\.contentContainer))
    }
    
    public var containerList: ValueBuilder {
        .base(.reference(\.containerContent))
    }
    
    public var containerCard: ValueBuilder {
        .base(.reference(\.accentContainer))
    }
    
    public var containerAction: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .any, .primary:
                    .reference(\.accentContainer)
                case .secondary, .tertiary:
                    .reference(\.accentElement)
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
