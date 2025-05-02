//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapCore
import SnapStyleBase
import Observation

@Observable
class Configuration: Hashable, Equatable {
    
    var accent: SnapStyle.Accent
    
    init(accent: SnapStyle.Accent = SnapStyle.Accent.fallback) {
        self.accent = accent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(accent)
    }
    
    static func == (lhs: Configuration, rhs: Configuration) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
}
