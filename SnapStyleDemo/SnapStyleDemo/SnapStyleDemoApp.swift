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
                .styleOverride(
                    numbers: [
                        \.cornerRadiusComponent : .base(.reference(demoConfiguration.cornerRadius.valueComponent)),
                        \.cornerRadiusMetricCard : .base(.reference(demoConfiguration.cornerRadius.valueMetricCard)),
                    ],
                )
                .styleSetup(style) // TODO: Should this be placed last?
                .style(accent: demoConfiguration.accentPrimary)
                .style(accentSecondary: demoConfiguration.accentSecondary)
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
