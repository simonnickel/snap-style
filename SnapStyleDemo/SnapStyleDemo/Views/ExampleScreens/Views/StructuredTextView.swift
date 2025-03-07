//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StructuredTextView: View {
    
    var body: some View {
        StyleVStack(spacing: \.spacingGroups) {
            StyleVStack {
                Text("Title")
                Text("Subitle")
                    .style(hierarchy: .secondary)
            }
            .style(element: .title)
            
            paragraph
            
            StyleVStack(spacing: \.spacingElements) {
                Text("Section Title")
                    .style(element: .title, hierarchy: .tertiary)
                
                paragraph
            }
        }
    }
    
    private var paragraph: some View {
        Text("Paragraph with some text to fill a few lines. This is supposed to be a block of text that can be read properly. While the other elements are supposed to provide context and structure to it.")
            .style(element: .any)
    }
    
}


// MARK: - Preview

#Preview {
    StructuredTextView()
}
