//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI


// MARK: - StyleScreen

// TODO: Docu no longer fits.
/// A container to define a Screen.
/// - Content is stacked vertically in a ScrollView.
/// - Elements are spaced by`NumberKey.spacingSections`.
/// - Insets content from .horizontal edges using safeAreaPadding:
///     - by `NumberKey.paddingScreen`
///     - to limit width to `NumberKey.widthReadableContent`
///     - *Caution: content (and background) needs to respect .horizontal safe area insets to comply.*
/// - By default `Component.screen` is used for styling.
public struct StyleScreen<ScreenContent>: View where ScreenContent: View {
    
    private let component: SnapStyle.ComponentDefinition
    
    private let configuration: [StyleScreenConfiguration]
    
    public typealias ContentBuilder = () -> ScreenContent
    private let content: ContentBuilder
    
    public init(
        component: SnapStyle.ComponentDefinition = .screen,
        configuration: [StyleScreenConfiguration] = .content,
        @ViewBuilder content: @escaping () -> ScreenContent
    ) {
        self.component = component
        self.configuration = configuration
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            createContent()
                .environment(\.screenGeometrySize, geometry.size) // TODO: Also calculate contentSize?
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .modifier(ModifierScreenInset(allowOverflow: configuration.contains(.readableContentWidth(allowOverflow: true))))
        // Background of screen should ignore .vertical safe area to stretch beyond \.`widthReadableContent`.
        .style(composition: \.screen, ignoreSafeAreaEdges: .vertical) // TODO: Should be the .container composition from given component.
        .style(component: component, applyContainer: nil)
    }
    
    // TODO: Could this move into readable content container?
    internal struct ModifierScreenInset: ViewModifier {
        
        let allowOverflow: Bool
        
        func body(content: Content) -> some View {
            content
                .if(allowOverflow) { content in
                    // Using safe area padding to inset the content.
                    // Requires the contents background to respect .horizontal safe area insets.
                    content.style(safeAreaPadding: \.paddingScreenHorizontal, .horizontal)
                } else: { content in
                    // Using content margins to inset the content.
                    content.style(contentMargins: \.paddingScreenHorizontal, .horizontal, placement: .scrollContent)
                }
                .style(safeAreaPadding: \.paddingScreenVertical, .vertical)
        }
    }
    
    @ViewBuilder
    private func createContent() -> some View {
        content()
            .if(configuration.contains(.verticalSectionSpacing)) { content in
                content.modifier(ConfigurationModifierVerticalSections())
            }
            .if(configuration.contains(.scrollView)) { content in
                content.modifier(ConfigurationModifierScrollView())
            }
            .if(configuration.contains(.readableContentWidth(allowOverflow: true))) { content in
                content.modifier(ConfigurationModifierReadableContentContainer(allowOverflow: true))
            }
            .if(configuration.contains(.readableContentWidth(allowOverflow: false))) { content in
                content.modifier(ConfigurationModifierReadableContentContainer(allowOverflow: false))
            }
    }
    
}


// MARK: - Preview

#Preview {
    NavigationStack {
        StyleScreen(configuration: [.scrollView, .verticalSectionSpacing, .readableContentWidth(allowOverflow: true)]) {
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
            
            VStack {
                Text("Or put inside another container.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.green, ignoresSafeAreaEdges: .vertical)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Scroll view automatic behaviour.
            ScrollView(.horizontal) {
                LazyHStack {
                    Text("ScrollView automatically allows to scroll behind safe area!")
                        .font(.system(size: 60))
                }
                .background(.green)
            }
        }
        .navigationTitle("Preview")
#if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
//    .styleOverride(
//        numbers: [
//            \.widthReadableContent: .base(.definition(.value(200)))
//        ]
//    )
}
