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
        .styleOverride(
            fonts: [
                .title : SnapStyle.ValueBuilder(.definition(.init(size: 6))) { context in
                    switch context.item.hierarchy {
                        case .primary: .definition(.init(size: 16))
                        default: .erase
                    }

                }
            ],
            surfaces: [
                .title : SnapStyle.ValueBuilder { context in
                    switch context.item.hierarchy {
                        case .secondary: .surface(.init(foreground: Color.primary))
                        default: nil
                    }
                }
            ]
        )
//        .styleOverride(
//            fonts: [
//                .title : SnapStyle.ValueBuilder { context in
//                    switch context.item.hierarchy {
//                        case.secondary: .definition(.init(size: 10))
//                        default: nil
//                    }
//                }
//            ],
//            surfaces: [
//                .title : SnapStyle.ValueBuilder { context in
//                    switch context.item.hierarchy {
//                        case .primary: .surface(.init(foreground: Color.primary))
//                        default: nil
//                    }
//                }
//            ]
//        )
}
