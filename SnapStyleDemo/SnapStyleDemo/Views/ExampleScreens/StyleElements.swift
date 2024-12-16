//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StyleElements: View {
    var body: some View {
        Text("Title")
            .style(element: .title)
        Text("Secondary Title")
            .style(element: .title, hierarchy: .secondary)
        Text("Tertiary Title")
            .style(element: .title, hierarchy: .tertiary)
        Text("Block with some more words to be like a paragraph with multiple lines.")
            .style(element: .content)
        HStack {
            Text("Label")
                .style(element: .label)
            Text("Value")
                .style(element: .value)
            Text("Indicator")
                .style(element: .indicator)
        }
        HStack {
            Button {} label: { Text("Button") }
                .style(element: .cta)
            Button {} label: { Text("Button") }
                .style(element: .cta, hierarchy: .secondary)
            Button {} label: { Text("Button") }
                .style(element: .cta, hierarchy: .tertiary)
        }
    }
}

#Preview {
    StyleElements()
}
