//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StructuredTextScreen: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Title")
                Text("Subitle")
                    .style(hierarchy: .secondary)
            }
            .style(element: .title)
            
            paragraph
            
            Text("Section Title")
                .style(element: .title, hierarchy: .tertiary)
            
            paragraph
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .style(component: .content)
    }
    
    private var paragraph: some View {
        Text("Paragraph with some text to fill a few lines. This is supposed to be a block of text that can be read properly. While the other elements are supposed to provide context and structure to it.")
            .style(element: .content)
    }
    
}

#Preview {
    StructuredTextScreen()
}
