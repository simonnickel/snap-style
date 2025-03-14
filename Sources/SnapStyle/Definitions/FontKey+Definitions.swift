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
                case .any: .definition(.with(size: 20, weight: .bold))
                case .primary: .definition(.with(size: 20, weight: .bold))
                case .secondary: .definition(.with(size: 16, weight: .medium))
                case .tertiary: .definition(.with(size: 16, weight: .medium))
            }
        }
    }
    
    public var label: ValueBuilder { .base(nil) }
    
    public var icon: ValueBuilder { .base(nil) }
    
    public var value: ValueBuilder { .base(nil) }
    
    public var separator: ValueBuilder { .base(nil) }
    
    
    // MARK: - Label
    
    public var listSectionheader: ValueBuilder {
        .base(.definition(.font(.system(size: 16, weight: .medium)))) // TODO: re-use the title.secondary value. Either by extracting it into a seperate var or by .reference with hierarchy adjustment.
    }
    
}
