//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct Style {

    internal var builderContainer: BuilderContainer = .init()
    internal var cacheContainer: CacheContainer = .init()
    
    package let configuration: Configuration

    public init(configuration: Configuration = .init()) {
        self.configuration = configuration
    }

}
