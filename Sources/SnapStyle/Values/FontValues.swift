//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

class FontValues: DefaultValues {
    
    typealias Key = SnapStyle.FontKey
    typealias Value = Key.Value
    typealias ValueBuilder = SnapStyle.ValueBuilder<Value>

    static func values(for key: Key) -> ValueBuilder {
        switch key {

            case .title: { context in
                switch context.hierarchy {
                    case .primary: .definition(.init(size: 18))
                    case .secondary: .definition(.init(size: 16))
                    case .tertiary: .definition(.init(size: 14))
                }
            }

            case .label: { context in
                switch context.component {
                case .card: .font(.caption)
                    default: .font(.body)
                }
            }

            case .content: { context in
                .reference(.label)
            }

            case .value: { context in
                .reference(.label)
            }

            case .cta: { context in
                .reference(.title)
            }

            case .indicator: { context in
                .reference(.label)
            }

        }
    }
    
}
