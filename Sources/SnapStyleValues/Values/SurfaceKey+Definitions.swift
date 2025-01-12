//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle.SurfaceKey {
    
 
    // MARK: - Element

    public var title: ValueBuilder { .base(.surface(.withColor(foreground: .mint))) }

    public var content: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .primary: .surface(.withColor(foreground: .primary))
                case .secondary: .surface(.withColor(foreground: .secondary))
                case .tertiary: .surface(.withColor(foreground: .secondary))
            }
        }
    }

    public var label: ValueBuilder { .base(.reference(\.content)) }

    public var value: ValueBuilder { .base(.reference(\.interactive)) }

    public var cta: ValueBuilder {
        .builder { context in
                .surface(.init(
                    foreground: Color.white,
                    background: Gradient(colors: [.blue, .yellow])
                ))
        }
    }

    public var indicator: ValueBuilder { .base(.reference(\.content)) }
    

    // MARK: - Highlight

    public var interactive: ValueBuilder { .base(.surface(.withColor(foreground: .accentColor))) }

    public var navigation: ValueBuilder { .base(.reference(\.interactive)) }
    
}
