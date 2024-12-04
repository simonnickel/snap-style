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


            // MARK: - Item

            case .title: { context in
                .surface(.init(foreground: .mint))
            }

            case .content: { context in
                switch context.hierarchy {
                    case .primary: .surface(.init(foreground: Color.primary))
                    case .secondary: .surface(.init(foreground: Color.secondary))
                    case .tertiary: .surface(.init(foreground: Color.secondary))
                }
            }

            case .label: { context in
                .reference(.content)
            }

            case .value: { context in
                .reference(.interactive)
            }

            case .cta: { context in
                .surface(.init(
                    foreground: .white,
                    background: Gradient(colors: [.blue, .yellow])
                ))
            }

            case .indicator: { context in
                .reference(.content)
            }


            // MARK: - Highlight

            case .interactive: { context in
                .surface(.init(foreground: Color.accentColor))
            }

            case .navigation: { context in
                .reference(.interactive)
            }

        }
    }
    
}
