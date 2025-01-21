//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ShapeKey {
    
    
    // MARK: - Container
    
    public var componentContainer: ValueBuilder {
        .builder { context in
            switch context.component.type {
                case .any: .reference(\.containerAnyComponent)
                case .content: .reference(\.containerContent)
                case .list: .reference(\.containerList)
                case .card: .reference(\.containerCard)
            }
        }
    }

    public var containerAnyComponent: ValueBuilder { .base(nil) }
    public var containerContent: ValueBuilder { .base(.definition(.value(.rectangle(cornerRadius: \.cornerRadiusContent)))) }
    public var containerList: ValueBuilder { .base(.definition(.value(.rectangle(cornerRadius: \.cornerRadiusList)))) }
    public var containerCard: ValueBuilder  { .base(.definition(.value(.rectangle(cornerRadius: \.cornerRadiusCard)))) }
    
}
