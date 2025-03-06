//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {
    

    // MARK: - Component
    
    public var anyComponent: ValueBuilder { .base(nil) }
    
    public var content: ValueBuilder { .base(.definition(.font(.system(size: 16)))) }
    public var card: ValueBuilder { .base(.definition(.font(.system(size: 18)))) }

 
    // MARK: - Element
    
    public var anyElement: ValueBuilder { .base(nil) }
    
    public var title: ValueBuilder {
        .base(.definition(.font(.title))) { context in
            return switch context.element.hierarchy {
                case .any: .definition(.with(size: 20))
                case .primary: .definition(.with(size: 20))
                case .secondary: .definition(.with(size: 16))
                case .tertiary: .definition(.with(size: 16))
            }
        }
    }
    
    public var label: ValueBuilder { .base(nil) }
    
    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }
    
    public var separator: ValueBuilder { .base(nil) }
    
}
