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
        
        @State var demoConfiguration = DemoConfiguration()
        @State var style: Style = Style(
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
                        \.primary : .base(.reference(demoConfiguration.accentPrimary)),
                        \.secondary : .base(.reference(demoConfiguration.accentSecondary)),
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
