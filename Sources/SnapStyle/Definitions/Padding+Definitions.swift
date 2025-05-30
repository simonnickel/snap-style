//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ComponentDefinition.Padding {
    
    static var listRow: Self {
        .init(
            leading: \.spacingListRowLeading,
            top: \.spacingListRowTop,
            trailing: \.spacingListRowTrailing,
            bottom: \.spacingListRowBottom
        )
    }
    
}
