//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.NumberKey {

    public var spacingSections: ValueBuilder { .base(.definition(.value(32))) }
    public var spacingGroups: ValueBuilder { .base(.definition(.value(16))) }
    public var spacingElements: ValueBuilder { .base(.definition(.value(8))) }
    public var spacingLines: ValueBuilder { .base(.definition(.value(4))) }
    
    
    // MARK: - Padding
    
    public var paddingComponent: ValueBuilder {
        .builder { context in
            switch context.component.type {
                case .any: .reference(\.paddingAnyComponent)
                case .screen: .reference(\.paddingScreen)
                case .content: .reference(\.paddingContent)
                case .list: .reference(\.paddingList)
                case .card: .reference(\.paddingCard)
            }
        }
    }
    
    public var paddingAnyComponent: ValueBuilder { .base(nil) }
    public var paddingScreen: ValueBuilder { .base(.definition(.value(8))) }
    public var paddingContent: ValueBuilder { .base(.definition(.value(12))) }
    public var paddingList: ValueBuilder { .base(.definition(.value(12))) }
    public var paddingCard: ValueBuilder { .base(.definition(.value(16))) }
    
}
