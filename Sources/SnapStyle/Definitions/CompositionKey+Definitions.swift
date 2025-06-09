//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// Composition is used to:
// - define surfaces for different layers
// - select surfaces based on the component state and level

extension SnapStyle.CompositionKey {
    
    
    // MARK: - Generic Compositions
    
    public var interactiveElement: ValueBuilder {
        .builder { context in
            
            let foreground: SnapStyle.SurfaceKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.onAccent : \.interactive
            let background: SnapStyle.SurfaceKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.interactionStateOverlay : \.interactionStateOverlayAccent
            
            return switch context.component.state {
                case .normal: .definition(.foreground(foreground))
                    
                case .disabled: .definition(.foreground(\.disabled))
                    
                case .highlighted, .selected:
                        .definition(.layers([
                            .foreground: foreground, .background: background
                        ]))
            }
        }
    }
    
    /// An indicator on an interactive Component, like an icon in a list row.
    public var interactiveIndicator: ValueBuilder {
        .builder { context in
            
            let foreground: SnapStyle.SurfaceKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.onAccent : \.interactive
            
            return switch context.component.state {
                case .normal: .definition(.foreground(foreground))
                    
                case .disabled: .definition(.foreground(\.disabled))
                    
                case .highlighted, .selected: .definition(.foreground(foreground))
            }
        }
    }
    
    public var listRow: ValueBuilder {
        .builder { context in
            return switch context.component.state {
                case .disabled:
                        .definition(.layers([
                            .foreground: \.disabled, .background: \.content0, .backgroundOverlay: \.interactionStateOverlayAccent
                        ]))
                    
                case .normal, .highlighted, .selected:
#if os(macOS)
                        .definition(.layers([
                            .foreground: \.onContent0, .backgroundOverlay: \.interactionStateOverlayAccent
                        ]))
#else
                        .definition(.layers([
                            .foreground: \.onContent0, .background: \.content0, .backgroundOverlay: \.interactionStateOverlayAccent
                        ]))
#endif
            }
        }
    }
    
    public var interactiveContainer: ValueBuilder {
        .builder { context in
            
            let foreground: SnapStyle.SurfaceKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.onContent0 : \.onInteractive
            let background: SnapStyle.SurfaceKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.content0 : \.interactive
            let overlay: SnapStyle.SurfaceKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.interactionStateOverlayAccent : \.interactionStateOverlay

            return switch context.component.state {
                case .disabled:
                        .definition(.layers([
                            .foreground: \.onDisabled, .background: \.disabled
                        ]))
                    
                case .normal, .highlighted, .selected:
                        .definition(.layers([
                            .foreground: foreground, .background: background, .backgroundOverlay: overlay
                        ]))
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
    
    public var containerValueCard: ValueBuilder {
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

    public var separator: ValueBuilder { .base(.definition(.foreground(\.onContent1))) }

}
