//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.FontKey {
    
    public var title: ValueBuilder {
        .init { context in
            switch context.item.hierarchy {
                case .primary: .definition(.init(size: 18))
                case .secondary: .definition(.init(size: 16))
                case .tertiary: .definition(.init(size: 14))
            }
        }
    }
    
    public var label: ValueBuilder {
        .init(.font(.body)) { context in
            switch context.component.type {
                case .card: .font(.caption)
                default: nil
            }
        }
    }
    
    public var content: ValueBuilder { .init(.reference(\.label)) }
    
    public var value: ValueBuilder { .init(.reference(\.label)) }
    
    public var cta: ValueBuilder { .init(.reference(\.label)) }
    
    public var indicator: ValueBuilder { .init(.reference(\.label)) }
    
}
