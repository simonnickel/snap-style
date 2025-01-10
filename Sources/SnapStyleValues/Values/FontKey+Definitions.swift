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
        .base(.font(.title)) { context in
            switch context.element.hierarchy {
                case .primary: .definition(.init(size: 20))
                case .secondary: .definition(.init(size: 14))
                case .tertiary: .definition(.init(size: 12))
            }
        }
    }
    
    public var content: ValueBuilder { .base(.reference(\.label)) }
    
    public var label: ValueBuilder {
        .base(.font(.body)) { context in
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
