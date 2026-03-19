//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct TabContainer: View {
    
    var body: some View {
        TabView {
            Tab {
                ConfigurationButtonContainer {
                    SnapStyleFlow(root: .root)
                }
            } label: {
                Label("SnapStyle", systemImage: "square.stack.3d.forward.dottedline.fill")
            }
            Tab {
                ConfigurationButtonContainer {
                    ContentFlow(root: .rootExamples)
                }
            } label: {
                Label("Examples", systemImage: "square.stack.3d.forward.dottedline.fill")
            }
            Tab {
                ConfigurationButtonContainer {
                    ToolsFlow(root: .root)
                }
            } label: {
                Label("Tools", systemImage: "wrench.and.screwdriver.fill")
            }
            Tab {
                VanillaFlow(root: .root)
            } label: {
                Label("Vanilla", systemImage: "slider.horizontal.2.square.on.square")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }

}


// MARK: - Preview

#Preview {
    TabContainer()
}
