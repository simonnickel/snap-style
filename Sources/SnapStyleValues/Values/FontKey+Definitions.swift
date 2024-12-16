//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle.FontKey {
    
    internal static var defaultKeyPaths: [ValueKeyPath] {
        return [\.title, \.content, \.label, \.value, \.cta, \.indicator]
    }
    
 
    // MARK: - Element
    
    public var title: ValueBuilder {
        .baseAnd(.font(.title)) { context in
            switch context.element.hierarchy {
                case .primary: .definition(.init(size: 18))
                case .secondary: .definition(.init(size: 16))
                case .tertiary: .definition(.init(size: 14))
            }
        }
    }
    
    public var content: ValueBuilder { .base(.reference(\.label)) }
    
    public var label: ValueBuilder {
        .baseAnd(.font(.body)) { context in
            switch context.component.type {
                case .card: .font(.caption)
                default: nil
            }
        }
    }
    
    public var value: ValueBuilder { .base(.reference(\.label)) }
    
    public var cta: ValueBuilder { .base(.reference(\.label)) }
    
    public var indicator: ValueBuilder { .base(.reference(\.label)) }
    
}
