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
            switch context.component.state {
                case .highlighted: .definition(.surface(.with(foreground: \.accent, background: \.accentOverlay)))

                case .selected: .definition(.surface(.with(foreground: \.accent, background: \.accentBaseAlt)))

                case .disabled: .definition(.surface(.with(foreground: \.onLight2, background: nil)))

                default: .definition(.surface(.with(foreground: \.accent, background: nil)))
            }
        }
    }
    
    public var interactiveContainer: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .highlighted: .definition(.surface(.with(foreground: \.onAccent, background: \.accentOverlay)))

                case .selected: .definition(.surface(.with(foreground: \.onAccent, background: \.accentBaseAlt)))

                case .disabled: .definition(.surface(.with(foreground: \.onAccent, background: \.onLight2)))

                default:
                    switch context.component.level {
                        case 1: .definition(.surface(.with(foreground: \.onAccent, background: \.accent)))
                        case 2: .definition(.surface(.with(foreground: \.onAccent, background: \.accentLevel2)))
                        case 3: .definition(.surface(.with(foreground: \.onAccent, background: \.accentLevel3)))
                        default: nil
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
