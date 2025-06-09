//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentContentScreen: View {
    var body: some View {
        StyleScreen {

            content

            StyleVStack(spacing: \.spacingGroups) {
                StyleVStack {
                    Text("Secondary")
                        .style(element: .title)
                    Text("Content inside of Content")
                        .style(element: .title, hierarchy: .secondary)
                }
                content
            }
            .style(component: .contentCard)
            
        }
    }
    
    private var content: some View {
        StyleVStack(spacing: \.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
        .style(component: .contentCard)
    }

}


// MARK: - Preview

#Preview {
    ComponentContentScreen()
}
