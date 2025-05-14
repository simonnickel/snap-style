//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.IconKey {
    
    
    // MARK: - Common

    public var favorite: ValueBuilder { .base(.definition(.value("star"))) }
    
    
    // MARK: - Controls
    
    public var selectionOff: ValueBuilder { .base(.definition(.value("circle"))) }
    public var selectionOn: ValueBuilder { .base(.definition(.value("checkmark.circle.fill"))) }
    
}
