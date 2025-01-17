//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {

 
    // MARK: - Element
    
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
    
    public var content: ValueBuilder { .base(.reference(\.label)) }
    
    public var label: ValueBuilder {
        .base(.definition(.font(.body))) { context in
            switch context.component.type {
                case .card: .definition(.font(.caption))
                default: nil
            }
        }
    }
    
    public var icon: ValueBuilder { .base(.reference(\.label)) }
    
    public var value: ValueBuilder { .base(.reference(\.label)) }
    
    public var cta: ValueBuilder { .base(.reference(\.label)) }
    
    public var indicator: ValueBuilder { .base(.definition(.font(.footnote))) }
    
}
