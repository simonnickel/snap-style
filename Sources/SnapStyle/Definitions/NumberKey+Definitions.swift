//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.NumberKey {
    
    
    // MARK: - Spacing

    public var spacingSections: ValueBuilder { .base(.definition(.value(32))) }
    public var spacingGroups: ValueBuilder { .base(.definition(.value(16))) }
    public var spacingElements: ValueBuilder { .base(.definition(.value(8))) }
    public var spacingLines: ValueBuilder { .base(.definition(.value(4))) }
    
    
    // MARK: - Padding
    
    public var paddingScreen: ValueBuilder { .base(.definition(.value(10))) }
    
    // TODO: How does that fit into components?
//    public var paddingComponent: ValueBuilder {
//        .builder { context in
//            switch context.component.type {
//                case .any: .reference(\.paddingAnyComponent)
//                case .content: .reference(\.paddingContent)
//                case .list: .reference(\.paddingList)
//                case .card: .reference(\.paddingCard)
//            }
//        }
//    }

    public var paddingAnyComponent: ValueBuilder { .base(nil) }
    public var paddingContent: ValueBuilder { .base(.definition(.value(12))) }
    public var paddingList: ValueBuilder { .base(.definition(.value(12))) }
    public var paddingCard: ValueBuilder { .base(.definition(.value(16))) }
    
    
    // MARK: - CornerRadius
    
    public var cornerRadiusContent: ValueBuilder { .base(.definition(.value(20))) }
    public var cornerRadiusList: ValueBuilder { .base(.reference(\.cornerRadiusContent)) }
    public var cornerRadiusCard: ValueBuilder { .base(.definition(.value(8))) }
    
    
    // MARK: - Elements
    
    public var listSeparator: ValueBuilder { .base(.definition(.value(1))) }
    
}
