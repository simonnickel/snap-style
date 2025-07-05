//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Observation
import SnapStyle
import SwiftUI

@Observable
class DemoConfiguration {

    var accent: SnapStyle.Accent

    var scaleFactor: SnapStyle.Context.ScaleFactor
    
    var fontDesign: Font.Design?

    var fontWidth: Font.Width?

    init(
        accent: SnapStyle.Accent = SnapStyle.Accent.fallback,
        scaleFactor: SnapStyle.Context.ScaleFactor = SnapStyle.Context.scaleFactorDefault,
        fontDesign: Font.Design? = SnapStyle.Context.fontDesignDefault,
        fontWidth: Font.Width? = SnapStyle.Context.fontWidthDefault
    ) {
        self.accent = accent
        self.scaleFactor = scaleFactor
        self.fontDesign = fontDesign
        self.fontWidth = fontWidth
    }

}


// MARK: - Environment

extension EnvironmentValues {

    @Entry var demoConfiguration: DemoConfiguration = DemoConfiguration()

}
