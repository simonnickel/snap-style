//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentActionScreen: View {
    
    @State private var showIcons: Bool = false
    @State private var showSubtitles: Bool = false
    
    private var elements: [ActionButtonsView.Element] {
        var elements: [ActionButtonsView.Element] = []
        if showIcons { elements.append(.icon) }
        if showSubtitles { elements.append(.subtitle) }
        return elements
    }
    
    var body: some View {
        StyleScreen {
            
            Toggle(isOn: $showIcons) {
                Text("Show Icons")
            }
            Toggle(isOn: $showSubtitles) {
                Text("Show Subtitles")
            }

            StyleStack(spacing: \.spacingElements) {
                Text("Content Card - Accent")
                    .style(element: .title)
                ActionButtonsView(elements: elements)
                ActionButtonsView(elements: elements)
                    .enabled(false)
                ActionButtonsView(elements: elements)
                    .style(accent: \.destructive)
            }
            .style(component: .contentCard)
            
            StyleStack(spacing: \.spacingElements) {
                Text("Accent Card - Alternative")
                    .style(element: .title)
                ActionButtonsView(elements: elements)
                ActionButtonsView(elements: elements)
                    .enabled(false)
                ActionButtonsView(elements: elements)
                    .style(accent: \.destructive)
            }
            .style(component: .accentCard)
            
            StyleStack(spacing: \.spacingElements) {
                Text("Icons")
                    .style(element: .title)
                StyleStack(.horizontal) {
                    StyleButton(.icon(hierarchy: .primary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                    StyleButton(.icon(hierarchy: .secondary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                    StyleButton(.icon(hierarchy: .tertiary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                }
            }
            .style(component: .contentCard)

            StyleButton(.component(.contentCard)) {} content: {
                StructuredTextView(title: "Interactive Content Card")
            }

            StyleButton(.component(.accentCard)) {} content: {
                StructuredTextView(title: "Interactive Accent Card")
            }

        }
    }
}


// MARK: - Preview

#Preview {
    ComponentActionScreen()
}
