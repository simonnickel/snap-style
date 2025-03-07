//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct StructuredScreen: View {
    
    var body: some View {
        StyleScreen {
            contentCardRow
            
            content
                .style(component: .content)
            
            content
                .style(component: .content)
        }
        .navigationTitle("Structured")
    }
    
    @ViewBuilder
    private var contentCardRow: some View {
        ScrollingHStack {
            contentCard
            contentCard
            contentCard
            contentCard
            contentCard
            contentCard
            contentCard
        }
    }
    
    @ViewBuilder
    private var content: some View {
        StyleVStack(spacing: \.spacingSections) {
            contentCards
            StructuredTextView()
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
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder
    private var contentList: some View {
        // TODO list: Style a List without using List
        StyleVStack {
            ForEach(0..<3) { index in
                StyleVStack {
                    StyleHStack {
                        Label("Row \(index)", systemImage: "star")
                            .padding(5) // TODO list: Element Padding, ListRow as Component?
                        Spacer()
                        Text("\(index)")
                    }
                    StyleShape(shape: .rectangle, surface: \.separator)
                        .frame(height: 1) // TODO list: Use number \.listSeparator
                }
            }
        }
        // TODO list: New style of component
//        .style(component: .list)
    }
    
    @ViewBuilder
    private var contentButtons: some View {
        StyleHStack {
            StyleButton {} content: {
                Label("Action", systemImage: "star")
            }
            
            Spacer()
            
            StyleButton {} content: {
                Label("Action", systemImage: "star")
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        StructuredScreen()
            .styleOverride(
                colors: [
                    \.onAccent : SnapStyle.ValueBuilder.builder { context in
                            .definition(.value(.yellow))
                    }
                ]
            )
    }
}
