//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Keys.Shape {

    public var containerRelative: ValueBuilder { .base(.definition(.containerRelative)) }
    public var circle: ValueBuilder { .base(.definition(.circle)) }
    

    // MARK: - Component

    public var anyContainer: ValueBuilder { .base(nil) }
    public var containerCard: ValueBuilder {
        .builder { context in
            if context.componentStack.levelOverall > 1 {
                .definition(.containerRelative)
            } else {
                .definition(.rectangleRounded(radius: \.cornerRadiusCard))
            }
        }
    }
    public var containerMetricCard: ValueBuilder { .base(.definition(.rectangleRounded(radius: \.cornerRadiusMetricCard))) }
    public var containerAction: ValueBuilder { .base(.definition(.capsule)) }
    public var containerActionIcon: ValueBuilder { .base(.definition(.circle)) }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

}
