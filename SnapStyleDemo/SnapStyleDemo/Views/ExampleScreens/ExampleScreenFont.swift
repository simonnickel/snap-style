//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ExampleScreenFont: View {
    
    var body: some View {
        VStack {
            content
                .environment(\.styleContext, .main)
            
            content
                .environment(\.styleContext, .card)
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title)
            Text("Subtitle")
                .font(.subtitle)
            Text("Block with some more words to be like a paragraph with multiple lines.")
            Text("Label")
        }
    }
    
}

#Preview {
    ExampleScreenFont()
}
