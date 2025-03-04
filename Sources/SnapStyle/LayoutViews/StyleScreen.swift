//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

// TODO: Debug modifier that overlays a GeometryReader and displays the values.

import SnapStyleBase
import SwiftUI

/// A container to define a Screen.
/// - Content is stacked vertically in a ScrollView.
/// - Elements are spaced by`NumberKey.spacingSections`.
/// - Insets content from .horizontal edges using safeAreaPadding:
///     - by `NumberKey.paddingScreen`
///     - to limit width to `NumberKey.widthReadableContent`
///     - *Caution: content (and background) needs to respect .horizontal safe area insets to comply.*
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
        GeometryReader { geometry in
            ScrollView {
                StyleVStack {
                    containerContent(geometry: geometry)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        // Using safe area padding to inset the content. Requires the contents background to respect .horizontal safe area insets (see SurfaceKey.Value.LayeredShapeStyle.ignoresSafeAreaEdgesDefault).
        .style(safeAreaPadding: \.paddingScreen, .horizontal)
        .style(component: component)
        .styleContextBase()
    }
    
    // TODO: Consider moving this into a separate View. Provide Geometry via environment.
    @ViewBuilder
    private func containerContent(geometry: GeometryProxy) -> some View {
        if let maxWidth = maxWidthContent {
            StyleVStack(spacing: \.spacingSections) {
                content()
            }
            .style(maxWidth: keyPathMaxWidthContent)
            .safeAreaPadding(.init(horizontal: (geometry.size.width - maxWidth) / 2, vertical: 0))
        } else {
            content()
        }
    }
    
    private let keyPathMaxWidthContent: SnapStyle.NumberKey.ValueBuilderKeyPath = \.widthReadableContent
    private var maxWidthContent: CGFloat? {
        switch style.value(for: keyPathMaxWidthContent, in: styleContext) {
            case .value(let value): value
            case .none: nil
        }
        
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
                        .font(.system(size: 60))
                }
                .background(.green)
            }
        }
    }
//    .styleOverride(
//        numbers: [
//            \.widthReadableContent: .base(.definition(.value(200)))
//        ]
//    )
}
