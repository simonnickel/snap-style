//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StructuredTextScreen: View {
    
    // TODO: Replace spacings with Style Values
    
    var body: some View {
        ScrollView {
            StyleVStack(spacing: 16) {
                contentText
                contentList
                contentButtons
            }
            .padding() // TODO: Should not be necessary, could be part of component or screen definition
        }
        .style(component: .content)
    }
    
    @ViewBuilder
    private var contentText: some View {
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
    
    @ViewBuilder
    private var contentList: some View {
        // TODO: Style a List without using List
        StyleVStack {
            ForEach(0..<3) { index in
                StyleVStack {
                    Label("Row \(index)", systemImage: "star")
                        .padding(5)
                    Rectangle()
                        .fill(Color.gray.secondary) // TODO: Style value
                        .frame(height: 1)
                }
            }
        }
        .style(component: .list)
    }
    
    @ViewBuilder
    private var contentButtons: some View {
        StyleHStack {
            // TODO: Secondary Button Style
            Button {} label: {
                Label("Action", systemImage: "star")
            }
            .buttonStyle(.borderless)
            .style(element: .cta, hierarchy: .secondary)
            
            Spacer()
            
            // TODO: Primary Button Style
            Button {} label: {
                Label("Action", systemImage: "star")
            }
            .buttonStyle(.borderedProminent)
            .style(element: .cta, hierarchy: .primary)
        }
    }
    
    private var paragraph: some View {
        Text("Paragraph with some text to fill a few lines. This is supposed to be a block of text that can be read properly. While the other elements are supposed to provide context and structure to it.")
            .style(element: .content)
    }
    
}

#Preview {
    StructuredTextScreen()
}
