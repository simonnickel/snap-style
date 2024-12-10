//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle.SurfaceKey {
 
    // MARK: Item

    public var title: ValueBuilder { .init(.surface(.withColor(foreground: .mint))) }

    public var content: ValueBuilder {
        .init { context in
            switch context.item.hierarchy {
                case .primary: .surface(.withColor(foreground: .primary))
                case .secondary: .surface(.withColor(foreground: .secondary))
                case .tertiary: .surface(.withColor(foreground: .secondary))
            }
        }
    }

    public var label: ValueBuilder { .init(.reference(\.content)) }

    public var value: ValueBuilder { .init(.reference(\.interactive)) }

    public var cta: ValueBuilder {
        .init { context in
                .surface(.init(
                    foreground: Color.white,
                    background: Gradient(colors: [.blue, .yellow])
                ))
        }
    }

    public var indicator: ValueBuilder { .init(.reference(\.content)) }
    

    // MARK: Highlight

    public var interactive: ValueBuilder {  .init(.surface(.withColor(foreground: .accentColor))) }

    public var navigation: ValueBuilder { .init(.reference(\.interactive)) }
    
}
