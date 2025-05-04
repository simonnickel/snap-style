//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapCore
import SnapStyleBase
import Observation

@Observable
class Configuration {
    
    var accent: SnapStyle.Accent
    
    init(accent: SnapStyle.Accent = SnapStyle.Accent.fallback) {
        self.accent = accent
    }
    
}
