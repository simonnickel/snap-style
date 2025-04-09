//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ButtonsScreen: View {
    
    var body: some View {
        StyleScreen {

            StyleVStack {
                StyleHStack {
                    StyleButton(.secondary) {} content: {
                        Label("Secondary", systemImage: "star")
                    }
                    
                    Spacer()
                    
                    StyleButton {} content: {
                        Label("Primary", systemImage: "star")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .style(component: .content)

            StyleVStack {
                Text("Disabled")
                    .style(element: .title)
                StyleHStack {
                    StyleButton(.secondary, state: .disabled) {} content: {
                        Label("Secondary", systemImage: "star")
                    }
                    
                    Spacer()
                    
                    StyleButton(state: .disabled) {} content: {
                        Label("Primary", systemImage: "star")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .style(component: .content)

        }
        .navigationTitle("Buttons")
    }
    
}

#Preview {
    ButtonsScreen()
}
