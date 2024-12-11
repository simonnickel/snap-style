//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

@main
struct SnapStyleDemoApp: App {
    
    let style: SnapStyle = SnapStyle.defaults
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.style, style)
        }
    }
}
