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
public struct StyleScreen<ScreenContent>: View where ScreenContent : View {
    
    private let component: SnapStyle.ComponentDefinition
    
    private let configuration: [Configuration]
    
    public typealias ContentBuilder = () -> ScreenContent
    private let content: ContentBuilder
    
    public init(
        component: SnapStyle.ComponentDefinition = .screen,
        configuration: [Configuration] = [.scrollView, .readableContentWidth, .verticalSections],
        @ViewBuilder content: @escaping () -> ScreenContent
    ) {
        self.component = component
        self.configuration = configuration
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            createContent()
                .environment(\.screenGeometrySize, geometry.size)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        // Using safe area padding to inset the content. Requires the contents background to respect .horizontal safe area insets.
        .style(safeAreaPadding: \.paddingScreenHorizontal, .horizontal)
        .style(safeAreaPadding: \.paddingScreenVertical, .vertical)
        // Background of screen should ignore .vertical safe area to stretch beyond \.`widthReadableContent`.
        .style(composition: \.screen, ignoreSafeAreaEdges: .vertical) // TODO: Should be the .container composition from given component.
        .style(component: component, applyContainer: nil)
    }
    
    
    // MARK: Configuration
    
    public enum Configuration {
        case readableContentWidth
        case scrollView
        case verticalSections // TODO: Could be .vertical(spacing:)
    }
    
    @ViewBuilder
    private func createContent() -> some View {
        
        content()
            .if(configuration.contains(.verticalSections)) { content in
                content.modifier(ConfigurationModifierVerticalSections())
            }
            .if(configuration.contains(.scrollView)) { content in
                content.modifier(ConfigurationModifierScrollView())
            }
            .if(configuration.contains(.readableContentWidth)) { content in
                content.modifier(ConfigurationModifierReadableContentContainer())
            }
    }
    
    internal struct ConfigurationModifierReadableContentContainer: ViewModifier {
        func body(content: Content) -> some View {
            ReadableContentContainer {
                content
            }
        }
    }
    
    internal struct ConfigurationModifierScrollView: ViewModifier {
        func body(content: Content) -> some View {
            ScrollView {
                content
            }
        }
    }
    
    internal struct ConfigurationModifierVerticalSections: ViewModifier {
        func body(content: Content) -> some View {
            StyleVStack(spacing: \.spacingSections) {
                content
            }
        }
    }
    
    
    // MARK: ReadableContentContainer
    
    struct ReadableContentContainer<ReadableContent: View>: View {
        
        private struct Constants {
            static var keyPathMaxWidthContent: SnapStyle.NumberKey.ValueBuilderKeyPath { \.widthReadableContent }
        }
        
        @Environment(\.style) private var style
        @Environment(\.screenGeometrySize) private var screenGeometrySize
        
        let content: () -> ReadableContent
        
        var body: some View {
            if let maxWidth = style.number(for: Constants.keyPathMaxWidthContent) {
                StyleVStack(spacing: \.spacingSections) {
                    content()
                }
                .safeAreaPadding(.init(horizontal: (screenGeometrySize.width - maxWidth) / 2, vertical: 0))
            } else {
                content()
            }
        }
        
    }
    
}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry public var screenGeometrySize: CGSize = .zero

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
