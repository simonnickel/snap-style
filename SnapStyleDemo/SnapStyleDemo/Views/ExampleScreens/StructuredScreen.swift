//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StructuredScreen: View {
    
    var body: some View {
        StyleScreen {
            contentCards
            
            content
                .style(component: .content)
            
            content
                .style(component: .content)
        }
        .navigationTitle("Structured")
    }
    
    @ViewBuilder
    private var content: some View {
        StyleVStack(spacing: \.spacingSections) {
            contentCards
            contentText
            contentList
            contentButtons
        }
    }
    
    @ViewBuilder
    private var contentCards: some View {
        StyleHStack(spacing: \.spacingElements) {
            contentCard
            contentCard
        }
    }
    
    @ViewBuilder
    private var contentCard: some View {
        // TODO: Content Style with Shape
        StyleVStack() {
            StyleHStack(spacing: \.spacingElements, alignment: .top) {
                Text("Title")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .style(element: .title, hierarchy: .primary)
                Text("Value")
                    .style(element: .value)
            }
            
            Spacer()
            
            StyleHStack(spacing: \.spacingElements, alignment: .bottom) {
                Text("Subitle")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .style(element: .title, hierarchy: .secondary)
                Spacer()
                Image(systemName: "triangle")
                    .style(element: .icon)
            }
        }
        .style(component: .card)
    }
    
    @ViewBuilder
    private var contentText: some View {
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
    
    @ViewBuilder
    private var contentList: some View {
        // TODO: Style a List without using List
        StyleVStack {
            ForEach(0..<3) { index in
                StyleVStack {
                    StyleHStack {
                        Label("Row \(index)", systemImage: "star")
                            .padding(5) // TODO: Element Padding, ListRow as Component?
                        Spacer()
                        Text("\(index)")
                    }
                    Rectangle()
                        .fill(Color.gray.secondary) // TODO: Style value, by defining a StyleShape
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
            .style(element: .any)
    }
    
}

#Preview {
    NavigationStack {
        StructuredScreen()
    }
}
