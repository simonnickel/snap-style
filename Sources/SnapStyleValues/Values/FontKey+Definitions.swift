//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.FontKey {
    
    public var title: ValueBuilder {
        .context { context in
            switch context.item.hierarchy {
                case .primary: .definition(.init(size: 18))
                case .secondary: .definition(.init(size: 16))
                case .tertiary: .definition(.init(size: 14))
            }
        }
    }
    
    public var label: ValueBuilder {
        .baseAnd(.font(.body)) { context in
            switch context.component.type {
                case .card: .font(.caption)
                default: nil
            }
        }
    }
    
    public var content: ValueBuilder { .base(.reference(\.label)) }
    
    public var value: ValueBuilder { .base(.reference(\.label)) }
    
    public var cta: ValueBuilder { .base(.reference(\.label)) }
    
    public var indicator: ValueBuilder { .base(.reference(\.label)) }
    
}
