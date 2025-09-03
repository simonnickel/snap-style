//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
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
        let style: SnapStyle = SnapStyle(
            configuration: .init(
                allowNavigationBarTitleAdjustments: true
            )
        )
        
        var body: some View {
            TabContainer()
                .style(accent: \.primary)
                .styleOverride(
                    numbers: [
                        \.cornerRadiusComponent : .base(.reference(demoConfiguration.cornerRadius.valueComponent)),
                        \.cornerRadiusMetricCard : .base(.reference(demoConfiguration.cornerRadius.valueMetricCard)),
                    ],
                    accents: [
                        \.primary : .base(.definition(.value(demoConfiguration.accentPrimary))),
                        \.secondary : .base(.definition(.value(demoConfiguration.accentSecondary))),
                    ]
                )
                .styleSetup(style)
                .style(scaleFactor: demoConfiguration.scaleFactor)
                .style(fontDesign: demoConfiguration.fontDesign)
                .style(fontWidth: demoConfiguration.fontWidth)
                .environment(\.demoConfiguration, demoConfiguration)
        }
    }

}


// MARK: - Preview

#Preview {
    SnapStyleDemoApp.Content()
}
