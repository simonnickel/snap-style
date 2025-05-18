//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import Observation

@Observable
class Configuration {
    
    var accent: SnapStyle.Accent

    var scaleFactor: SnapStyle.Context.ScaleFactor

    init(
        accent: SnapStyle.Accent = SnapStyle.Accent.fallback,
        scaleFactor: SnapStyle.Context.ScaleFactor = SnapStyle.Context.scaleFactorDefault
    ) {
        self.accent = accent
        self.scaleFactor = scaleFactor
    }
    
}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry var configuration: Configuration = Configuration()
    
}
