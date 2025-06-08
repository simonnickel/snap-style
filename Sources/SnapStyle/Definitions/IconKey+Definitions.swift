//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.IconKey {


    // MARK: - Common

    public var favorite: ValueBuilder { .base(.definition(.value("star"))) }
    public var scaleFactor: ValueBuilder { .base(.definition(.value("square.resize"))) }
    public var fontDesign: ValueBuilder { .base(.definition(.value("textformat"))) }


    // MARK: - Controls

    public var selectionOff: ValueBuilder { .base(.definition(.value("circle"))) }
    public var selectionOn: ValueBuilder { .base(.definition(.value("checkmark.circle.fill"))) }

}
