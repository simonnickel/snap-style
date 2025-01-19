//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {
    

    // MARK: - Component
    
    public var anyComponent: ValueBuilder { .base(nil) }
    
    public var component: ValueBuilder {
        .builder { context in
            switch context.component.type {
                case .any: .reference(\.anyComponent)
                case .screen: .reference(\.screen)
                case .content: .reference(\.content)
                case .list: .reference(\.list)
                case .card: .reference(\.card)
            }
        }
    }
    
    public var screen: ValueBuilder { .base(nil) }
    public var content: ValueBuilder { .base(.definition(.font(.system(size: 16)))) }
    public var list: ValueBuilder { .base(.reference(\.content)) }
    public var card: ValueBuilder { .base(.definition(.font(.system(size: 18)))) }

 
    // MARK: - Element
    
    public var anyElement: ValueBuilder { .base(nil) }
    
    public var element: ValueBuilder {
        .builder { context in
            switch context.element.type {
                case .any: .reference(\.anyElement)
                case .title: .reference(\.title)
                case .label: .reference(\.label)
                case .icon: .reference(\.icon)
                case .value: .reference(\.value)
                case .cta: .reference(\.cta)
            }
        }
    }
    
    public var title: ValueBuilder {
        .base(.definition(.font(.title))) { context in
            if context.component.type == .card {
                return switch context.element.hierarchy {
                    case .any: .definition(.with(size: 24))
                    case .primary: .definition(.with(size: 24))
                    case .secondary: .definition(.with(size: 20))
                    case .tertiary: .definition(.with(size: 20))
                }
            } else {
                return switch context.element.hierarchy {
                    case .any: .definition(.with(size: 20))
                    case .primary: .definition(.with(size: 20))
                    case .secondary: .definition(.with(size: 16))
                    case .tertiary: .definition(.with(size: 16))
                }
            }
        }
    }
    
    public var label: ValueBuilder { .base(nil) }
    
    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }
    
    public var cta: ValueBuilder { .base(nil) }
    
}
