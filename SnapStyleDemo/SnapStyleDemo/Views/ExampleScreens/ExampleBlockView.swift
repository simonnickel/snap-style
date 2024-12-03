//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ExampleBlockView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title)
                .color(.highlight)
            Text("Subtitle")
                .font(.subtitle)
            Text("Block with some more words to be like a paragraph with multiple lines.")
                .font(.block)
            Text("Label")
                .font(.label)
            Text("Note")
                .font(.note)
            Text("Value")
                .font(.value)
            
            Image(systemName: "rectangle")
                .font(.icon)
            Image(systemName: "chevron.right")
                .font(.indicator)
        }
    }
}

#Preview {
    ExampleBlockView()
        .environment(\.styleContext, .card)
}
