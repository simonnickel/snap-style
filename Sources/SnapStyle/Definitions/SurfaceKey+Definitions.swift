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
                    case .normal: .definition(.foreground(\.onDark0))
                    case .highlighted: .definition(.layers([.foreground: \.onDark0, .background: \.accentOverlay]))
                    case .selected: .definition(.layers([.foreground: \.onDark0, .background: \.accentMuted]))
                    case .disabled: .definition(.foreground(\.disabled))
                }
            } else {
                switch context.component.state {
                    case .normal: .definition(.foreground(\.interactive))
                    case .highlighted: .definition(.layers([.foreground: \.interactive, .background: \.accentOverlay]))
                    case .selected: .definition(.layers([.foreground: \.onAccent, .background: \.accentMuted]))
                    case .disabled: .definition(.foreground(\.disabled))
                }
            }
        }
    }
    
    public var interactiveContainer: ValueBuilder {
        .builder { context in
            if context.component.useAlternativeAccent {
                switch context.component.state {
                    case .normal: .definition(.layers([.foreground: \.onContent0, .background: \.content0]))
                    case .highlighted: .definition(.layers([.foreground: \.onDark0, .background: \.accentOverlay]))
                    case .selected: .definition(.layers([.foreground: \.onInteractive, .background: \.accentMuted]))
                    case .disabled: .definition(.layers([.foreground: \.onDisabled, .background: \.disabled]))
                }
            } else {
                switch context.component.state {
                    case .normal: .definition(.layers([.foreground: \.onInteractive, .background: \.interactive]))
                    case .highlighted: .definition(.layers([.foreground: \.onInteractive, .background: \.interactiveHighlighted]))
                    case .selected: .definition(.layers([.foreground: \.onInteractive, .background: \.interactiveSelected]))
                    case .disabled: .definition(.layers([.foreground: \.onDisabled, .background: \.disabled]))
                }
            }
        }
    }
    
    public var contentContainer: ValueBuilder {
        .builder { context in
            switch context.component.level {
                case 1: .definition(.layers([.foreground: \.onContent0, .background: \.content0]))
                case 2: .definition(.background(\.content1))
                case 3: .definition(.background(\.content2))
                default: nil
            }
        }
    }

    public var accentContainer: ValueBuilder {
        .builder { context in
            switch context.component.level {
                case 1: .definition(.layers([.foreground: \.onAccent, .background: \.accent]))
                case 2: .definition(.layers([.foreground: \.onAccent, .background: \.accentLevel2]))
                case 3: .definition(.layers([.foreground: \.onAccent, .background: \.accentLevel3]))
                default: nil
            }
        }
    }

    
    // MARK: - Component: Container
    
    public var anyContainer: ValueBuilder { .base(nil) }
    
    public var screen: ValueBuilder {
        .builder { context in
            .definition(.surface(.with(
                [.background: \.screen],
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

    public var separator: ValueBuilder { .base(.definition(.foreground(\.onContent1))) } // TODO: Better color definition

}
