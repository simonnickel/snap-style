//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Attribute.Padding {

    public var listRow: ValueBuilder {
        .base(.value(.edge(
            leading: \.paddingListRowLeading,
            top: \.paddingListRowTop,
            trailing: \.paddingListRowTrailing,
            bottom: \.paddingListRowBottom
        )))
    }

    public var screenTitleLeading: ValueBuilder {
        .base(.value(.edges([.leading], value: \.paddingCard)))
    }

    public var containerCard: ValueBuilder {
        .base(.value(.all(\.paddingCard)))
    }
    
    public var containerMetricCard: ValueBuilder {
        .base(.value(.all(\.paddingMetricCard)))
    }
    
    public var containerAction: ValueBuilder {
        .base(.value(.axis(horizontal: \.paddingActionHorizontal, vertical: \.paddingActionVertical)))
    }
    
    public var containerActionIconOnly: ValueBuilder {
        .base(.value(.all(\.paddingActionIconOnly)))
    }
    
    
    // MARK: - Component

    public var anyContainer: ValueBuilder { .base(nil) }

    
    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

}
