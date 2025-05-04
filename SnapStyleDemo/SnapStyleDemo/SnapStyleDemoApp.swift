//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

@main
struct SnapStyleDemoApp: App {
    
    let configuration = Configuration()
    let style: SnapStyle = SnapStyle()
    
    var body: some Scene {
        WindowGroup {
            ContentFlow()
                .style(setup: style)
                .style(accent: configuration.accent)
                .environment(configuration)
        }
    }

}
