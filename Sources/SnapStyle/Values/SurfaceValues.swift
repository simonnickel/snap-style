//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

class SurfaceValues: DefaultValues {

    typealias Key = SnapStyle.SurfaceKey
    typealias Value = Key.Value
    typealias ValueBuilder = SnapStyle.ValueBuilder<Value>

    static func values(for key: Key) -> ValueBuilder {
        switch key {

            case .fallback: { component, hierarchy in
                .surface(.init(foreground: Color.pink, background: Color.yellow))
            }


            // MARK: - Item

            case .title: { component, hierarchy in
                .surface(.init(foreground: .mint))
            }

            case .content: { component, hierarchy in
                switch hierarchy {
                    case .primary: .surface(.init(foreground: Color.primary))
                    case .secondary: .surface(.init(foreground: Color.secondary))
                    case .tertiary: .surface(.init(foreground: Color.secondary))
                }
            }

            case .label: { component, hierarchy in
                .reference(.content)
            }

            case .value: { component, hierarchy in
                .reference(.interactive)
            }

            case .cta: { component, hierarchy in
                .surface(.init(
                    foreground: .white,
                    background: Gradient(colors: [.blue, .yellow])
                ))
            }

            case .indicator: { component, hierarchy in
                .reference(.content)
            }


            // MARK: - Highlight

            case .interactive: { component, hierarchy in
                .surface(.init(foreground: Color.accentColor))
            }

            case .navigation: { component, hierarchy in
                .reference(.interactive)
            }

        }
    }
    
}
