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
            
            let foreground: SnapStyle.ColorKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.onAccent : \.interactive
            let background: SnapStyle.ColorKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.interactionStateOverlay : \.interactionStateOverlayAccent
            
            return switch context.component.state {
                case .normal: .definition(
                    .foreground(foreground)
                )
                    
                case .disabled: .definition(.foreground(\.disabled))
                    
                default: .definition(.layers([
                    .foreground: foreground, .background: background
                ]))
            }
        }
    }
    
    public var interactiveContainer: ValueBuilder {
        .builder { context in
            
            let foreground: SnapStyle.ColorKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.onContent0 : \.onInteractive
            let background: SnapStyle.ColorKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.content0 : \.interactive
            let overlay: SnapStyle.ColorKey.ValueBuilderKeyPath = context.component.useAlternativeAccent ? \.interactionStateOverlayAccent : \.interactionStateOverlay

            return switch context.component.state {
                case .disabled: .definition(.layers([.foreground: \.onDisabled, .background: \.disabled]))
                default: .definition(.layers([
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
