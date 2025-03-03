//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// TODO: Limit width similar to UIKit's readableContentGuide

/// A container to define a Screen.
/// - Content is stacked vertically in a ScrollView.
/// - Elements are spaced by`NumberKey.spacingSections`.
/// - Uses safeAreaPadding to inset content from the edges, using `NumberKey.paddingScreen`.
/// - By default `Component.screen` is used for styling.
public struct StyleScreen<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let component: SnapStyle.Component
    private let content: () -> Content
    
    public init(
        component: SnapStyle.Component = .screen,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.component = component
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            StyleVStack(spacing: \.spacingSections) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .style(safeAreaPadding: \.paddingScreen, .horizontal)
        .style(component: component)
        .styleContextBase()
    }
    
}


// MARK: - Preview

#Preview {
    NavigationStack {
        StyleScreen {
            // Default placement inside of safe area
            Rectangle()
            
            // Ignore safe area
            Rectangle()
                .ignoresSafeArea(.container, edges: .horizontal)
            
            // Background has to handle safe area.
            VStack {
                Text("Background ignores safe area by default!")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.green)
            VStack {
                Text("Needs to be handled manually.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.green, ignoresSafeAreaEdges: .vertical)
            
            // Scroll view automatic behaviour.
            ScrollView(.horizontal) {
                LazyHStack {
                    Text("ScrollView automatically allows to scroll behind safe area!")
                }
                .background(.green)
            }
        }
    }
}
