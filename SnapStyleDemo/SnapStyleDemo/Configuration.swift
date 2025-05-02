//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

@Observable
class Configuration {
    
    var accent: Color = .green
    
}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry var configuration: Configuration = Configuration()
    
}
