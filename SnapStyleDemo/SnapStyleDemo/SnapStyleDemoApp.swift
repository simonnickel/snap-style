//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

@main
struct SnapStyleDemoApp: App {
    
    let style: SnapStyle = SnapStyle()
    let configuration: Configuration = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentFlow()
                .style(update: style)
                .environment(\.configuration, configuration)
        }
    }
}
