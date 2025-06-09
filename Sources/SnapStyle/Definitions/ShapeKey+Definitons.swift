//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ShapeKey {


    // MARK: - Component

    public var anyContainer: ValueBuilder { .base(nil) }
    public var containerCard: ValueBuilder { .base(.definition(.value(.rectangleRounded(radius: \.cornerRadiusCard)))) }
    public var containerValueCard: ValueBuilder { .base(.definition(.value(.rectangleRounded(radius: \.cornerRadiusCard)))) }
    public var containerAction: ValueBuilder { .base(.definition(.value(.capsule))) }
    public var containerActionIcon: ValueBuilder { .base(.definition(.value(.circle))) }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

}
