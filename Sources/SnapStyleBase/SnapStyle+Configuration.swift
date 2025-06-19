//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    public struct Configuration {
        
        package let allowNavigationBarTitleAdjustments: Bool
        
        public init(allowNavigationBarTitleAdjustments: Bool = false) {
            self.allowNavigationBarTitleAdjustments = allowNavigationBarTitleAdjustments
        }
        
    }
    
}
