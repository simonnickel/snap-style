//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

// Composition is used to:
// - define surfaces for different layers
// - select surfaces based on the container state and level

extension Style.Attribute.Composition {
    
    
    // MARK: - Generic Compositions
    
    public var interactiveElement: ValueBuilder {
        .builder { context in
            switch context.container.state {
                case .normal: .value(.foreground(\.interactiveAsForeground))

                case .disabled, .inactive: .value(.foreground(\.disabled))
                    
                case .highlighted, .selected:
                        .value(.layers([
                            .foreground: \.interactiveAsForeground, .background: \.stateOverlayAccented
                        ]))
            }
        }
    }
    
    /// An indicator on an interactive Component, like an icon in a list row.
    public var interactiveIndicator: ValueBuilder {
        .builder { context in
            
            let foreground: Style.Attribute.Surface.ValueBuilderKeyPath = context.container.useSecondaryAccent ? \.onAccent : \.interactive
            
            return switch context.container.state {
                case .normal: .value(.foreground(foreground))
                    
                case .disabled, .inactive: .value(.foreground(\.disabled))
                    
                case .highlighted, .selected: .value(.foreground(foreground))
            }
        }
    }
    
    public var listRow: ValueBuilder {
        .builder { context in
#if os(macOS)
            return switch context.containerStack.currentState {
                case .disabled:
                    .value(.layers([
                        .foreground: \.disabled, .background: \.contentBackground
                    ]))

                case .normal, .inactive, .highlighted, .selected, .none:
                    .value(.layers([
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
            return switch context.container.state {
                case .disabled:
                    .value(.layers([
                        .foreground: \.disabled, .background: \.contentLevel1
                    ]))

                case .normal, .inactive, .highlighted, .selected:
                    .value(.layers([
                        .foreground: \.onContent0, .background: \.contentBackground, .backgroundOverlay: \.stateOverlayAccented
                    ]))
            }
        }
    }

    public var infoContainer: ValueBuilder {
        .base(.value(.layers([
            .foreground: \.onContent0, .background: \.contentLevel2, .backgroundOverlay: \.stateOverlayAccented
        ])))
    }
    
    public var accentContainer: ValueBuilder {
        .builder { context in
            switch context.container.state {
                case .disabled, .inactive:
                    .value(.layers([
                        .foreground: \.onDisabled, .background: \.disabled
                    ]))

                case .normal, .highlighted, .selected:
                    .value(.layers([
                        .foreground: \.onAccent, .background: \.accentBackground, .backgroundOverlay: \.stateOverlayOnAccent
                    ]))
            }
        }
    }

    public var interactiveContainer: ValueBuilder {
        .builder { context in
            return switch context.container.state {
                case .disabled, .inactive:
                        .value(.layers([
                            .foreground: \.onDisabled, .background: \.disabled
                        ]))

                case .normal, .highlighted, .selected:
                        .value(.layers([
                            .foreground: \.onInteractive,
                            .background: \.interactive,
                            .backgroundOverlay: \.stateOverlayOnInteractive,
                            .border: \.interactiveBorder,
                        ]))
            }
        }
    }


    // MARK: - Component: Container
    
    public var anyContainer: ValueBuilder { .base(nil) }
    
    public var screen: ValueBuilder {
        .base(.value(.composition(.with([.background: \.screen]))))
    }
    
    public var containerContentCard: ValueBuilder {
        .base(.reference(\.contentContainer))
    }
    
    public var containerInfoCard: ValueBuilder {
        .base(.reference(\.infoContainer))
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
            switch context.component.hierarchy {
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

    public var separator: ValueBuilder { .base(.value(.foreground(\.onContentDisabled))) }
    
    public var footnote: ValueBuilder { .base(nil) }

}
