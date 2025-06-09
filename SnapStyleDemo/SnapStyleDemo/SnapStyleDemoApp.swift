//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

@main
struct SnapStyleDemoApp: App {

    var body: some Scene {
        WindowGroup {
            Content()
        }
    }
    
    struct Content: View {
        
        let demoConfiguration = DemoConfiguration()
        let style: SnapStyle = SnapStyle()
        
        var body: some View {
            ConfigurationButtonContainer()
                .style(setup: style)
                .style(accent: demoConfiguration.accent)
                .style(scaleFactor: demoConfiguration.scaleFactor)
                .style(fontDesign: demoConfiguration.fontDesign)
                .environment(\.demoConfiguration, demoConfiguration)
        }
    }
}


// MARK: - Preview

#Preview {
    SnapStyleDemoApp.Content()
}
