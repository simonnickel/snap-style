//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension SnapStyle.IconKey {


    // MARK: - Common

    public var favorite: ValueBuilder { .base(.definition(.value("star"))) }
    public var indicatorNavigation: ValueBuilder { .base(.definition(.value("chevron.right"))) }
    public var indicatorUnread: ValueBuilder { .base(.definition(.value("circlebadge.fill"))) }
    public var indicatorMore: ValueBuilder { .base(.definition(.value("ellipsis"))) }

    
    // MARK: - Config
    public var scaleFactor: ValueBuilder { .base(.definition(.value("square.resize"))) }
    public var fontDesign: ValueBuilder { .base(.definition(.value("textformat"))) }
    public var configCornerRadius: ValueBuilder { .base(.definition(.value("button.roundedbottom.horizontal"))) }

    // MARK: - Controls

    public var selectionOff: ValueBuilder { .base(.definition(.value("circle"))) }
    public var selectionOn: ValueBuilder { .base(.definition(.value("checkmark.circle.fill"))) }

}
