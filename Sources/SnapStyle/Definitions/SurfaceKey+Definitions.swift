//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// Surface is used to:
// - combine foreground and background color
// - select colors based on the component (state, level)

extension SnapStyle.SurfaceKey {

    // TODO: Gradients
    // TODO: Materials
    
    // MARK: - Generic Surfaces
    
    public var interactiveElement: ValueBuilder {
        .builder { context in
            if context.component.useAlternativeAccent {
                switch context.component.state {
                    case .normal: .definition(.surface(.with(foreground: \.onDark0, background: nil)))
                    case .highlighted: .definition(.surface(.with(foreground: \.onDark0, background: \.accentOverlay)))
                    case .selected: .definition(.surface(.with(foreground: \.onDark0, background: \.accentMuted)))
                    case .disabled: .definition(.surface(.with(foreground: \.disabled, background: nil)))
                }
            } else {
                switch context.component.state {
                    case .normal: .definition(.surface(.with(foreground: \.interactive, background: nil)))
                    case .highlighted: .definition(.surface(.with(foreground: \.interactive, background: \.accentOverlay)))
                    case .selected: .definition(.surface(.with(foreground: \.onAccent, background: \.accentMuted)))
                    case .disabled: .definition(.surface(.with(foreground: \.disabled, background: nil)))
                }
            }
        }
    }
    
    public var interactiveContainer: ValueBuilder {
        .builder { context in
            if context.component.useAlternativeAccent {
                switch context.component.state {
                    case .normal: .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
                    case .highlighted: .definition(.surface(.with(foreground: \.onDark0, background: \.accentOverlay)))
                    case .selected: .definition(.surface(.with(foreground: \.onInteractive, background: \.accentMuted)))
                    case .disabled: .definition(.surface(.with(foreground: \.onDisabled, background: \.disabled)))
                }
            } else {
                switch context.component.state {
                    case .normal: .definition(.surface(.with(foreground: \.onInteractive, background: \.interactive)))
                    case .highlighted: .definition(.surface(.with(foreground: \.onInteractive, background: \.interactiveHighlighted)))
                    case .selected: .definition(.surface(.with(foreground: \.onInteractive, background: \.interactiveSelected)))
                    case .disabled: .definition(.surface(.with(foreground: \.onDisabled, background: \.disabled)))
                }
            }
        }
    }
    
    public var contentContainer: ValueBuilder {
        .builder { context in
            switch context.component.level {
                case 1: .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
                case 2: .definition(.surface(.with(background: \.content1)))
                case 3: .definition(.surface(.with(background: \.content2)))
                default: nil
            }
        }
    }

    public var accentContainer: ValueBuilder {
        .builder { context in
            switch context.component.level {
                case 1: .definition(.surface(.with(foreground: \.onAccent, background: \.accent)))
                case 2: .definition(.surface(.with(foreground: \.onAccent, background: \.accentLevel2)))
                case 3: .definition(.surface(.with(foreground: \.onAccent, background: \.accentLevel3)))
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
                    .reference(\.interactiveContainer)
                case .secondary, .tertiary:
                    .reference(\.interactiveElement)
            }
        }
    }
    

    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }
    
    public var title: ValueBuilder { .base(nil) }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }
    
    public var action: ValueBuilder { .base(nil) }

    public var separator: ValueBuilder { .base(.definition(.surface(.with(foreground: \.onContent1)))) } // TODO: Better color definition

}
