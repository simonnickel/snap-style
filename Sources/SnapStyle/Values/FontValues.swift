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
                
            case .fallback: { component, hierarchy in
                .definition(.init(size: 1))
            }

            case .title: { component, hierarchy in
                switch hierarchy {
                    case .primary: .definition(.init(size: 18))
                    case .secondary: .definition(.init(size: 16))
                    case .tertiary: .definition(.init(size: 14))
                }
            }

            case .label: { component, hierarchy in
                switch component {
                case .card: .font(.caption)
                    default: .font(.body)
                }
            }

            case .content: { component, hierarchy in
                .reference(.label)
            }

            case .value: { component, hierarchy in
                .reference(.label)
            }

            case .cta: { component, hierarchy in
                .reference(.title)
            }

            case .indicator: { component, hierarchy in
                .reference(.label)
            }

        }
    }
    
}
