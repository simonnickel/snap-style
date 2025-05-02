//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

@main
struct SnapStyleDemoApp: App {
    
    let style: SnapStyle = SnapStyle()
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
                .style(update: style)
        }
    }

}

struct AppContainer: View {
    
    @State private var configuration = Configuration()
    
    var body: some View {
        ContentFlow()
            .style(accent: configuration.accent)
            .environment(configuration)
    }

}
