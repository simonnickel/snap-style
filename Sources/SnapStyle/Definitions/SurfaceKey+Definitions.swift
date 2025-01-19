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
    
    public var component: ValueBuilder {
        .builder { context in
            switch context.component.type {
                case .any: .reference(\.anyComponent)
                case .content: .reference(\.content)
                case .list: .reference(\.list)
                case .card: .reference(\.card)
            }
        }
    }
    
    public var anyComponent: ValueBuilder { .base(nil) }
    
    public var content: ValueBuilder {
        .builder { context in
            switch context.component.hierarchy {
                case .any, .primary: .definition(.surface(.with(foreground: \.onContent0, background: \.content0)))
                case .secondary: .definition(.surface(.with(foreground: \.onContent0, background: \.content1)))
            }
        }
    }

    public var list: ValueBuilder { .base(.reference(\.content)) }
    
    public var card: ValueBuilder {
        .builder { context in
            switch context.component.hierarchy {
                case .any, .primary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent0)))
                case .secondary: .definition(.surface(.with(foreground: \.onAccent, background: \.accent1)))
            }
        }
    }
    

    // MARK: - Element
    
    public var element: ValueBuilder {
        .builder { context in
            switch context.element.type {
                case .any: .reference(\.anyElement)
                case .title: .reference(\.title)
                case .label: .reference(\.label)
                case .icon: .reference(\.icon)
                case .value: .reference(\.value)
                case .cta: .reference(\.cta)
                case .separator: .reference(\.separator)
            }
        }
    }

    public var anyElement: ValueBuilder { .base(nil) }
    
    public var title: ValueBuilder { .base(nil) }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }

    public var cta: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                .definition(.surface(.init(
                    foreground: \.onAccentAlt,
                    background: \.accentAlt
                )))
            } else {
                .definition(.surface(.init(
                    foreground: \.onAccent,
                    background: \.accent0
                )))
            }
        }
    }
    
    public var separator: ValueBuilder { .base(.definition(.surface(.with(foreground: \.onContent1)))) }
    
    
    // MARK: - States
    
    public var disabledContainer: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                .definition(.surface(.init(
                    background: \.content2
                )))
            } else {
                .definition(.surface(.init(
                    background: \.content1
                )))
            }
        }
    }
    
    public var disabledElement: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                .definition(.surface(.init(
                    foreground: \.content1
                )))
            } else {
                .definition(.surface(.init(
                    foreground: \.onContent1
                )))
            }
        }
    }
    
    public var highlightedContainer: ValueBuilder {
        .builder { context in
            return if context.component.type == .card {
                .definition(.surface(.init(
                    background: \.accentAlt
                )))
            } else {
                .definition(.surface(.init(
                    background: \.accentAlt
                )))
            }
        }
    }
    
    public var highlightedElement: ValueBuilder {
        .builder { context in
            if context.component.type == .card {
                .definition(.surface(.init(
                    foreground: \.accentAlt
                )))
            } else {
                .definition(.surface(.init(
                    foreground: \.accent0
                )))
            }
        }
    }

}
