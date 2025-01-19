//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {
    

    // MARK: - Component
    
    public var anyComponent: ValueBuilder { .base(nil) }
    
    public var screen: ValueBuilder { .base(nil) }
    
    public var content: ValueBuilder { .base(.definition(.font(.system(size: 16)))) }
    
    public var list: ValueBuilder { .base(.reference(\.content)) }
    
    public var card: ValueBuilder { .base(.definition(.font(.system(size: 18)))) }

 
    // MARK: - Element
    
    public var anyElement: ValueBuilder { .base(nil) }
    
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
