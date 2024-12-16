//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleValues
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
            StyleElements()
        }
    }

    private var content: some View {
        VStack(alignment: .leading) {
            StyleElements()
        }
    }

    private var list: some View {
        List {
            StyleElements()
        }
    }

}

#Preview {
    ComponentsScreen()
        .styleOverride(
            fonts: [
                \.title : SnapStyle.ValueBuilder.baseAnd(.definition(.init(size: 6))) { context in
                    switch context.element.hierarchy {
                        case .primary: .definition(.init(size: 16))
                        default: .erase
                    }

                }
            ],
            surfaces: [
                \.title : SnapStyle.ValueBuilder.context { context in
                    switch context.element.hierarchy {
                        case .secondary: .surface(.withColor(foreground: .primary))
                        default: nil
                    }
                }
            ]
        )
//        .styleOverride(
//            fonts: [
//                .title : SnapStyle.ValueBuilder { context in
//                    switch context.element.hierarchy {
//                        case.secondary: .definition(.init(size: 10))
//                        default: nil
//                    }
//                }
//            ],
//            surfaces: [
//                .title : SnapStyle.ValueBuilder { context in
//                    switch context.element.hierarchy {
//                        case .primary: .surface(.init(foreground: Color.primary))
//                        default: nil
//                    }
//                }
//            ]
//        )
}
