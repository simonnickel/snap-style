//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ShapeKey {
    
    
    // MARK: - Component
    
    public var anyContainer: ValueBuilder { .base(nil) }
    public var containerContent: ValueBuilder { .base(.definition(.value(.rectangleRounded(radius: \.cornerRadiusContent)))) }
    public var containerList: ValueBuilder { .base(.definition(.value(.rectangleRounded(radius: \.cornerRadiusList)))) } // TODO list: Is this needed?
    public var containerCard: ValueBuilder  { .base(.definition(.value(.rectangleRounded(radius: \.cornerRadiusCard)))) }
    public var containerAction: ValueBuilder  { .base(.definition(.value(.capsule))) }
    
    
    // MARK: - Element
    
    public var anyElement: ValueBuilder { .base(nil) }
    
}
