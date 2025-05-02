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
    
    @State private var accent: SnapStyle.Accent = .fallback
    
    var body: some Scene {
        WindowGroup {
            ContentFlow()
                .style(update: style)
                .style(attribute: SnapStyle.Context.accent, value: accent)
                .environment(\.configuration, configuration)
                .onChange(of: configuration) { oldValue, newValue in
                    accent = newValue.accent
                }
        }
    }
}
