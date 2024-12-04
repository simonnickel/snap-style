//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StyleItems: View {
    var body: some View {
        Text("Title")
            .style(item: .title)
        Text("Secondary Title")
            .style(item: .title, hierarchy: .secondary)
        Text("Tertiary Title")
            .style(item: .title, hierarchy: .tertiary)
        Text("Block with some more words to be like a paragraph with multiple lines.")
            .style(item: .content)
        HStack {
            Text("Label")
                .style(item: .label)
            Text("Value")
                .style(item: .value)
            Text("Indicator")
                .style(item: .indicator)
        }
        Button {} label: { Text("Button") }
            .style(item: .cta)
    }
}

#Preview {
    StyleItems()
}
