//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Attribute.Shape {

    public var containerRelative: ValueBuilder { .base(.value(.containerRelative)) }
    public var circle: ValueBuilder { .base(.value(.circle)) }
    

    // MARK: - Component

    public var anyContainer: ValueBuilder { .base(nil) }
    public var containerCard: ValueBuilder {
        .builder { context in 
            if context.containerStack.levelOverall > 1 {
                .value(.containerRelative)
            } else {
                .value(.rectangleRounded(radius: \.cornerRadiusCard))
            }
        }
    }
    public var containerMetricCard: ValueBuilder { .base(.value(.rectangleRounded(radius: \.cornerRadiusMetricCard))) }
    public var containerAction: ValueBuilder { .base(.value(.capsule)) }
    public var containerActionIconOnly: ValueBuilder { .base(.value(.circle)) }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

}
