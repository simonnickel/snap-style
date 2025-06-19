//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct TabContainer: View {
    
    var body: some View {
        TabView {
            Tab {
                ContentFlow()
            } label: {
                Label("Examples", systemImage: "square.stack.3d.forward.dottedline.fill")
            }
            Tab {
                ContentFlow()
            } label: {
                Label("Tools", systemImage: "light.beacon.max.fill")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}
