//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension SnapStyle.ShapeKey {

    public var containerRelative: ValueBuilder { .base(.definition(.value(.containerRelative))) }
    

    // MARK: - Component

    public var anyContainer: ValueBuilder { .base(nil) }
    public var containerCard: ValueBuilder {
        .builder { context in
            if context.componentStack.levelOverall > 1 {
                .definition(.value(.containerRelative))
            } else {
                .definition(.value(.rectangleRounded(radius: \.cornerRadiusCard)))
            }
        }
    }
    public var containerValueCard: ValueBuilder { .base(.reference(\.containerCard)) }
    public var containerAction: ValueBuilder { .base(.definition(.value(.capsule))) }
    public var containerActionIcon: ValueBuilder { .base(.definition(.value(.circle))) }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

}
