//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StructuredTextScreen: View {
    
    // TODO: Replace spacings with Style Values
    
    var body: some View {
        StyleVStack(spacing: 16) {
            content
        }
        .style(component: .content)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var content: some View {
        StyleVStack(spacing: 0) {
            Text("Title")
            Text("Subitle")
                .style(hierarchy: .secondary)
        }
        .style(element: .title)

        
        paragraph
        
        StyleVStack(spacing: 8) {
            Text("Section Title")
                .style(element: .title, hierarchy: .tertiary)
            
            paragraph
        }
    }
    
    private var paragraph: some View {
        Text("Paragraph with some text to fill a few lines. This is supposed to be a block of text that can be read properly. While the other elements are supposed to provide context and structure to it.")
            .style(element: .content)
    }
    
}

#Preview {
    StructuredTextScreen()
        .padding() // TODO: Should not be necessary, could be part of component or screen definition
}
