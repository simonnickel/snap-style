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
                    // TODO: Use NumberKey
                    // Using content margins to inset the content.
                    content.contentMargins(.horizontal, 10, for: .scrollContent)
                }
                .style(safeAreaPadding: \.paddingScreenVertical, .vertical)
        }
    }
    
    
    // MARK: Configuration
    
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
    
    internal struct ConfigurationModifierReadableContentContainer: ViewModifier {
        
        let allowOverflow: Bool
        
        func body(content: Content) -> some View {
            ReadableContentContainer(allowOverflow: allowOverflow) {
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
        
        let allowOverflow: Bool
        let content: () -> ReadableContent
        
        var body: some View {
            if let maxWidth = style.number(for: Constants.keyPathMaxWidthContent) {
                StyleVStack(spacing: \.spacingSections) {
                    content()
                }
                .if(allowOverflow) { content in
                    content
                        .safeAreaPadding(.init(horizontal: (screenGeometrySize.width - maxWidth) / 2, vertical: 0))
                } else: { content in
                    content
                        .contentMargins(.horizontal, (screenGeometrySize.width - maxWidth) / 2, for: .scrollContent)
                }
            } else {
                content()
            }
        }
        
    }
    
}


// MARK: - StyleScreenConfiguration

public enum StyleScreenConfiguration: Equatable {
    /// Restricts screen width to fit `\.widthReadableContent`
    ///
    /// - Parameters:
    ///   - allowOverflow: controls if scroll views and backgrounds are allowed to overflow the restriction.
    ///   Value`false` uses contentMargin instead of safeAreaPadding, e.g. necessary for ListStyle `.insetGrouped` to get rid of system inset and use `\.paddingScreenHorizontal`.
    case readableContentWidth(allowOverflow: Bool)
    
    /// Wraps content in a ScrollView.
    case scrollView
    
    /// Wraps content in a VStack with `\.spacingSections`.
    case verticalSectionSpacing
}

extension [StyleScreenConfiguration] {
    /// A default set of configurations for a typical content screen.
    public static var content: Self { [.scrollView, .readableContentWidth(allowOverflow: true), .verticalSectionSpacing] }
    
    /// A default set of configurations for a system list screen.
    public static var list: Self { [.readableContentWidth(allowOverflow: true), .verticalSectionSpacing] }
}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry public var screenGeometrySize: CGSize = .zero

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
