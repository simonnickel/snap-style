//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ComponentDefinition.Padding {

    static var listRow: Self {
        .init(
            leading: \.paddingListRowLeading,
            top: \.paddingListRowTop,
            trailing: \.paddingListRowTrailing,
            bottom: \.paddingListRowBottom
        )
    }

}
