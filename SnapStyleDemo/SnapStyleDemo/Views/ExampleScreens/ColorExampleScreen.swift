//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ColorExampleScreen: View {
    
    var body: some View {
        VStack {
            content
                .environment(\.styleContext, .main)
            
            content
                .environment(\.styleContext, .card)
                .styleOverride(fonts: [.block : .init(base: .definition(.init(size: 8)))])
        }
    }
    
    private var content: some View {
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
        }
    }
    
}

#Preview {
    ColorExampleScreen()
}
