//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Attribute.Icon {


    // MARK: - Common

    public var favorite: ValueBuilder { .base(.value(.named("star"))) }
    public var reset: ValueBuilder { .base(.value(.named("arrow.trianglehead.counterclockwise.rotate.90"))) }
    public var indicatorNavigation: ValueBuilder { .base(.value(.named("chevron.right"))) }
    public var indicatorUnread: ValueBuilder { .base(.value(.named("circlebadge.fill"))) }
    public var indicatorMore: ValueBuilder { .base(.value(.named("ellipsis"))) }
    public var settings: ValueBuilder { .base(.value(.named("gear"))) }
    public var edit: ValueBuilder { .base(.value(.named("square.and.pencil"))) }

    
    // MARK: - Config
    
    public var scaleFactor: ValueBuilder { .base(.value(.named("square.resize"))) }
    public var fontDesign: ValueBuilder { .base(.value(.named("textformat"))) }
    public var configCornerRadius: ValueBuilder { .base(.value(.named("button.roundedbottom.horizontal"))) }

    // MARK: - Controls

    public var selectionOff: ValueBuilder { .base(.value(.named("circle"))) }
    public var selectionOn: ValueBuilder { .base(.value(.named("checkmark.circle.fill"))) }

}
