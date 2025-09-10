//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.ComponentDefinition.Padding {

    static var listRow: Self {
        .init(
            leading: \.paddingListRowLeading,
            top: \.paddingListRowTop,
            trailing: \.paddingListRowTrailing,
            bottom: \.paddingListRowBottom
        )
    }

}
