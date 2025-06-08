//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

@main
struct SnapStyleDemoApp: App {

    let demoConfiguration = DemoConfiguration()
    let style: SnapStyle = SnapStyle()

    var body: some Scene {
        WindowGroup {
            ContentContainer()
                .style(setup: style)
                .style(accent: demoConfiguration.accent)
                .style(scaleFactor: demoConfiguration.scaleFactor)
                .style(fontDesign: demoConfiguration.fontDesign)
                .environment(\.demoConfiguration, demoConfiguration)
        }
    }

}
