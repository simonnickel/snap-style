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
    
    init(accent: SnapStyle.Accent = SnapStyle.Accent.fallback) {
        self.accent = accent
    }
    
}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry var configuration: Configuration = Configuration()
    
}
