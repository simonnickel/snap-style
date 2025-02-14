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
                    StyleButton {} content: {
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
        }
        .navigationTitle("Buttons")
    }
    
}

#Preview {
    ButtonsScreen()
}
