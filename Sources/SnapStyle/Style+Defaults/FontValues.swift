//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

class FontValues: ValueProvider {
    
    typealias Key = SnapStyle.FontKey
    typealias Value = Key.Value
    typealias ValueBuilder = SnapStyle.ValueBuilder<Value>

    static func values(for key: Key) -> ValueBuilder {
        switch key {

            case .title: ValueBuilder { context in
                switch context.item.hierarchy {
                    case .primary: .definition(.init(size: 18))
                    case .secondary: .definition(.init(size: 16))
                    case .tertiary: .definition(.init(size: 14))
                }
            }

            case .label: ValueBuilder(.font(.body)) { context in
                switch context.component.type {
                    case .card: .font(.caption)
                    default: nil
                }
            }

            case .content: ValueBuilder(.reference(.label))

            case .value: ValueBuilder(.reference(.label))

            case .cta: ValueBuilder(.reference(.label))

            case .indicator: ValueBuilder(.reference(.label))

        }
    }
    
}
