//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


class ColorValues: DefaultValues {
    
    typealias Key = SnapStyle.ColorKey
    typealias Value = Key.Value
    typealias ValueBuilder = SnapStyle.ValueBuilder<Value>

    static func values(for key: Key) -> ValueBuilder {
        switch key {

            case .fallback: { component, hierarchy in
                .color(.pink)
            }


            // MARK: - Item

            case .title: { component, hierarchy in
                .reference(.content)
            }

            case .content: { component, hierarchy in
                switch hierarchy {
                    case .primary: .color(.primary)
                    case .secondary: .color(.secondary)
                    case .tertiary: .color(.secondary)
                }
            }

            case .label: { component, hierarchy in
                .reference(.content)
            }

            case .value: { component, hierarchy in
                .reference(.interactive)
            }

            case .cta: { component, hierarchy in
                .reference(.interactive)
            }

            case .indicator: { component, hierarchy in
                .reference(.content)
            }


            // MARK: - Highlight

            case .interactive: { component, hierarchy in
                .color(.accentColor)
            }

            case .navigation: { component, hierarchy in
                .reference(.interactive)
            }

        }
    }
    
}
