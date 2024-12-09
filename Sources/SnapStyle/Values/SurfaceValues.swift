//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

class SurfaceValues: ValueProvider {

    typealias Key = SnapStyle.SurfaceKey
    typealias Value = Key.Value
    typealias ValueBuilder = SnapStyle.ValueBuilder<Value>

    static func values(for key: Key) -> ValueBuilder {
        switch key {


            // MARK: - Item

            case .title: ValueBuilder(.surface(.init(foreground: .mint)))

            case .content: ValueBuilder { context in
                switch context.item.hierarchy {
                    case .primary: .surface(.init(foreground: Color.primary))
                    case .secondary: .surface(.init(foreground: Color.secondary))
                    case .tertiary: .surface(.init(foreground: Color.secondary))
                }
            }

            case .label: ValueBuilder(.reference(.content))

            case .value: ValueBuilder(.reference(.interactive))

            case .cta: ValueBuilder { context in
                .surface(.init(
                    foreground: .white,
                    background: Gradient(colors: [.blue, .yellow])
                ))
            }

            case .indicator: ValueBuilder(.reference(.content))

            // MARK: - Highlight

            case .interactive: ValueBuilder(.surface(.init(foreground: Color.accentColor)))

            case .navigation: ValueBuilder(.reference(.interactive))

        }
    }
    
}
