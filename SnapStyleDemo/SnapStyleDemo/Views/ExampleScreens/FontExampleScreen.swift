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
                .environment(\.styleContext, .main)
            
            content
                .environment(\.styleContext, .card)
                .styleOverride(fonts: [.block : .init(base: .definition(.init(size: 8)))])
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text("Title")
            Text("Subtitle")
            Text("Block with some more words to be like a paragraph with multiple lines.")
            Text("Label")
        }
    }
    
}

#Preview {
    FontExampleScreen()
}
