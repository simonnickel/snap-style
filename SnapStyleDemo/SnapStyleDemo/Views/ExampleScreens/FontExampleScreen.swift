//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct FontExampleScreen: View {
    
    var body: some View {
        VStack {
            content
                .style(component: .content)

            content
                .style(component: .list)
                .styleOverride(
                    fonts: [
                        \.title : .builder({ context in
                            switch (context.component.type, context.element.hierarchy) {
                                case (.card, .secondary): .definition(.with(size: 40))
                                default: nil
                            }
                        })
                    ]
                )
        }
//        .styleOverride(
//            fonts: [
//                \.title : .builder({ context in
//                    switch (context.component.type, context.element.hierarchy) {
//                        case (.card, .primary): .definition(.init(size: 9))
//                        default: nil
//                    }
//                })
//            ]
//        )
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .style(element: .title)
            Text("Subtitle")
                .style(element: .title, hierarchy: .secondary)
            Text("Block with some more words to be like a paragraph with multiple lines.")
                .style(element: .any)
            Text("Label")
                .style(element: .label)
            Text("Font from Keypath")
                .style(font: \.cta)
        }
    }
    
}

#Preview {
    FontExampleScreen()
}
