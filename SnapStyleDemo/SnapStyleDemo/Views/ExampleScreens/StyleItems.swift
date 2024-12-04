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
        Text("Subtitle")
            .style(item: .title, hierarchy: .secondary)
        Text("Block with some more words to be like a paragraph with multiple lines.")
            .style(item: .content)
        Text("Label")
            .style(item: .label)
        Button {} label: { Text("Button") }
            .style(item: .cta)
    }
}

#Preview {
    StyleItems()
}
