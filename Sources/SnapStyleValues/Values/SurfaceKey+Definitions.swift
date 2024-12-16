//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle.SurfaceKey {
    
    internal static var defaultKeyPaths: [ValueKeyPath] {
        return [\.title, \.content, \.label, \.value, \.cta, \.indicator, \.interactive, \.navigation]
    }
    
 
    // MARK: - Element

    public var title: ValueBuilder { .base(.surface(.withColor(foreground: .mint))) }

    public var content: ValueBuilder {
        .context { context in
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
        .context { context in
                .surface(.init(
                    foreground: Color.white,
                    background: Gradient(colors: [.blue, .yellow])
                ))
        }
    }

    public var indicator: ValueBuilder { .base(.reference(\.content)) }
    

    // MARK: - Highlight

    public var interactive: ValueBuilder {  .base(.surface(.withColor(foreground: .accentColor))) }

    public var navigation: ValueBuilder { .base(.reference(\.interactive)) }
    
}
