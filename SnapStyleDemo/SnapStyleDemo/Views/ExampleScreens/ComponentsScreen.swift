//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentsScreen: View {
    
    var body: some View {
        VStack {
            HStack {
                card
                    .style(component: .card)
                card
                    .style(component: .card)
            }
            .style(component: .card)

            content
                .style(component: .content)

            list
                .style(component: .list)

        }
        .style(component: .screen)
    }

    private var card: some View {
        VStack(alignment: .leading) {
            StyleItems()
        }
    }

    private var content: some View {
        VStack(alignment: .leading) {
            StyleItems()
        }
    }

    private var list: some View {
        List {
            StyleItems()
        }
    }

}

#Preview {
    ComponentsScreen()
        .styleOverride(surfaces: [
            .title : { context in
                switch context.hierarchy {
                    case .primary: .surface(.init(foreground: Color.primary))
                    default: nil
                }
            }
        ])
}
