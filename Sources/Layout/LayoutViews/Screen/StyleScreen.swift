//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyleBase
import SnapStyleComponents
import SnapStyleKeyModifier
import SnapStyleDefinitions
import SwiftUI


// MARK: - StyleScreen

/// A container to define a Screen.
///
/// Also exposes some geometry metrics via environment: `\.geometrySizeScreen`, `\geometrySizeContent`.
/// - Parameters:
///     - component: The component to use as screen container, by default `Component.screen` is used.
///     - configuration: An array of `StyleScreenConfiguration` to define the behaviour of the screen.
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
        let composition = component.compositions?(.container) ?? \.screen

        GeometryReader { geometry in
            createContent()
                .environment(\.geometrySizeScreen, geometry.size)
                .environment(\.geometrySafeAreaInsets, geometry.safeAreaInsets)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        // Background of screen ignores safe area to stretch beyond toolbars and other insets (like dynamic island in iPhone landscape.
        .style(composition: composition, ignoreSafeAreaEdges: .all)
        .style(component: component, applyContainer: nil)
        .styleNavigationBar() /// (see ``StyleNavigationBarModifier``)
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
            .modifier(ConfigurationModifierInset(
                insetHorizontalEdges: configuration.contains(.insetHorizontalEdges),
                insetVerticalEdges: configuration.contains(.insetVerticalEdges),
                applyReadableWidth: configuration.contains(.readableContentWidth),
                allowOverflow: configuration.contains(.allowReadableContentOverflow)
            ))
    }
    
}


// MARK: - Preview

#Preview {
    NavigationStack {
        StyleScreen(configuration: [.scrollView, .verticalSectionSpacing, .insetHorizontalEdges, .readableContentWidth, .allowReadableContentOverflow]) {
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
