//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

@main
struct SnapStyleDemoApp: App {
    
    let style: SnapStyle = SnapStyle()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.style, style)
        }
    }
}
