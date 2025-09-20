//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

// Composition is used to:
// - define surfaces for different layers
// - select surfaces based on the component state and level

extension Style.Keys.Composition {
    
    
    // MARK: - Generic Compositions
    
    public var interactiveElement: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .normal: .definition(.foreground(\.interactiveAsForeground))

                case .disabled, .inactive: .definition(.foreground(\.disabled))
                    
                case .highlighted, .selected:
                        .definition(.layers([
                            .foreground: \.interactiveAsForeground, .background: \.stateOverlayAccented
                        ]))
            }
        }
    }
    
    /// An indicator on an interactive Component, like an icon in a list row.
    public var interactiveIndicator: ValueBuilder {
        .builder { context in
            
            let foreground: Style.Keys.Surface.ValueBuilderKeyPath = context.component.useSecondaryAccent ? \.onAccent : \.interactive
            
            return switch context.component.state {
                case .normal: .definition(.foreground(foreground))
                    
                case .disabled, .inactive: .definition(.foreground(\.disabled))
                    
                case .highlighted, .selected: .definition(.foreground(foreground))
            }
        }
    }
    
    public var listRow: ValueBuilder {
        .builder { context in
#if os(macOS)
            return switch context.component.state {
                case .disabled:
                        .definition(.layers([
                            .foreground: \.disabled, .background: \.contentBackground
                        ]))

                case .normal, .inactive, .highlighted, .selected:
                        .definition(.layers([
                            .foreground: \.onContent0, .backgroundOverlay: \.stateOverlayAccented
                        ]))
            }
#else
            .reference(\.contentContainer)
#endif
        }
    }

    public var contentContainer: ValueBuilder {
        .builder { context in
            return switch context.component.state {
                case .disabled:
                    .definition(.layers([
                        .foreground: \.disabled, .background: \.contentLevel1
                    ]))

                case .normal, .inactive, .highlighted, .selected:
                    .definition(.layers([
                        .foreground: \.onContent0, .background: \.contentBackground, .backgroundOverlay: \.stateOverlayAccented
                    ]))
            }
        }
    }
    
    public var accentContainer: ValueBuilder {
        .builder { context in
            switch context.component.state {
                case .disabled, .inactive:
                    .definition(.layers([
                        .foreground: \.onDisabled, .background: \.disabled
                    ]))

                case .normal, .highlighted, .selected:
                    .definition(.layers([
                        .foreground: \.onAccent, .background: \.accentBackground, .backgroundOverlay: \.stateOverlayOnAccent
                    ]))
            }
        }
    }

    public var interactiveContainer: ValueBuilder {
        .builder { context in
            return switch context.component.state {
                case .disabled, .inactive:
                        .definition(.layers([
                            .foreground: \.onDisabled, .background: \.disabled
                        ]))

                case .normal, .highlighted, .selected:
                        .definition(.layers([
                            .foreground: \.onInteractive, .background: \.interactive, .backgroundOverlay: \.stateOverlayOnInteractive
                        ]))
            }
        }
    }


    // MARK: - Component: Container
    
    public var anyContainer: ValueBuilder { .base(nil) }
    
    public var screen: ValueBuilder {
        .builder { context in
            .definition(.composition(.with(
                [.background: \.screen]
            )))
        }
    }
    
    public var containerContentCard: ValueBuilder {
        .base(.reference(\.contentContainer))
    }
    
    public var containerAccentCard: ValueBuilder {
        .base(.reference(\.accentContainer))
    }
    
    public var containerMetricCard: ValueBuilder {
        .base(.reference(\.accentContainer))
    }

    public var containerList: ValueBuilder {
        .base(.reference(\.contentContainer))
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
    
    public var accessory: ValueBuilder { .base(.reference(\.icon)) }
    
    public var value: ValueBuilder { .base(nil) }
    
    public var action: ValueBuilder { .base(nil) }

    public var separator: ValueBuilder { .base(.definition(.foreground(\.onContentDisabled))) }
    
    public var footnote: ValueBuilder { .base(nil) }

}
