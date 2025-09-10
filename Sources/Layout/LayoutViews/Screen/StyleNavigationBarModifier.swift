//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyleBase
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// TODO improvement:
/**
 The modifier `View.styleNavigationBar()` configures the `UINavigationBar` with Style definitions.
 It uses `UIKitViewControllerHookModifier` to get the responsible bar for the SwiftUI.View and updates the appearance on changes to the `ContextWrapper`. Changing the appearance proxy does not work, because the already rendered bar would not update.
 
 It would be enough to apply it once per NavigationStack, e.g. on the root screen. Currently SnapStyle does not handle NavigationStack though, to not interfere with SnapNavigation. Both could be combined for a smoother experience.
 
 To prevent unnecessary appearance config, the modifier requires `Style.configuration.styleAllowNavigationBarTitleAdjustments` to be enabled.
 */
extension View {
    
    /// Requires `Style.configuration.styleAllowNavigationBarTitleAdjustments` to be enabled.
    /// (see ``StyleNavigationBarModifier``)
    public func styleNavigationBar() -> some View {
        modifier(StyleNavigationBarModifier())
    }
}

private struct StyleNavigationBarModifier: ViewModifier {

    @Environment(\.style) private var style

    func body(content: Content) -> some View {
        let definitionInline = style.font(for: \.navigationTitleInline)
        let definitionLarge = style.font(for: \.navigationTitleLarge)
        
        if let definitionInline, let definitionLarge {
            content
#if canImport(UIKit)
                .if(style.definition.configuration.allowNavigationBarTitleAdjustments) { content in
                    content
                        .modifier(StyleNavigationBarScaledModifier(definitionInline: definitionInline, definitionLarge: definitionLarge))
                }
#endif
        } else {
            content
        }
    }
}


// MARK: - StyleNavigationBarScaledModifier

private struct StyleNavigationBarScaledModifier: ViewModifier {

    @Environment(\.style) private var style
    
    private let definitionInline: Style.Keys.Font.Value.Definition
    private let definitionLarge: Style.Keys.Font.Value.Definition
    private let scaledInline: ScaledMetric<Double>
    private let scaledLarge: ScaledMetric<Double>
    
    init(definitionInline: Style.Keys.Font.Value.Definition, definitionLarge: Style.Keys.Font.Value.Definition) {
        self.definitionInline = definitionInline
        self.definitionLarge = definitionLarge
        self.scaledInline = ScaledMetric(wrappedValue: definitionInline.size, relativeTo: definitionInline.textStyle)
        self.scaledLarge = ScaledMetric(wrappedValue: definitionLarge.size, relativeTo: definitionLarge.textStyle)
    }
    
#if !canImport(UIKit)
    func body(content: Content) -> some View {
        content
    }
#else
    @State private var navigationBar: UINavigationBar?

    func body(content: Content) -> some View {
        content
            .onViewWillAppear { vc in
                navigationBar = vc.navigationController?.navigationBar
                update()
            }
            .onChange(of: style.context.scaleFactor) { oldValue, newValue in
                update()
            }
            .onChange(of: style.context.fontDesign) { _, _ in
                update()
            }
// FontWidth is not that well supported in UIFontDescriptor.SymbolicTraits
//            .onChange(of: style.context.fontWidth) { oldValue, newValue in
//                update()
//            }
    }
    
    private func update() {
        if let navigationBar {
            Self.configure(
                navigationBar: navigationBar,
                with: style,
                scaledInline: scaledInline,
                scaledLarge: scaledLarge
            )
        }
    }
    
    private static func configure(
        navigationBar: UINavigationBar,
        with style: Style.ContextWrapper,
        scaledInline: ScaledMetric<Double>,
        scaledLarge: ScaledMetric<Double>
    ) {
        let fontInline = font(for: \.navigationTitleInline, with: style, size: scaledInline.wrappedValue)
        let fontLarge = font(for: \.navigationTitleLarge, with: style, size: scaledLarge.wrappedValue)
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: fontInline
        ]
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: fontLarge
        ]
    }
    
    private static func font(
        for keyPath: Style.Keys.Font.ValueBuilderKeyPath,
        with style: Style.ContextWrapper,
        size: Double
    ) -> UIFont {
        let design = style.context.fontDesign ?? .default
        let fontSizeMax = style.number(for: \.fontSizeNavigationTitleMax, scaled: false) ?? 60
        var fontStyle = style.font(for: keyPath)
        // Max size has to be limited, otherwise the text is shortened anyway.
        let size = min(size * style.context.scaleFactor, fontSizeMax)
        if let fontStyleR = fontStyle {
            fontStyle = .init(size: size, weight: fontStyleR.weight, width: fontStyleR.width, design: fontStyleR.design, textStyle: fontStyleR.textStyle)
        }
        
        var descriptor = if let fontStyle {
            fontStyle.uiFont().fontDescriptor
        } else {
            UIFont.preferredFont(forTextStyle: .largeTitle).fontDescriptor.withSymbolicTraits([.traitBold])
        }
        
        descriptor = descriptor?.withDesign(design.uiFontDesign)
        
        let font = if let descriptor {
            UIFont(descriptor: descriptor, size: descriptor.pointSize)
        } else {
            UIFont.preferredFont(forTextStyle: .largeTitle)
        }
        
        return font
    }
#endif

}


// MARK: - Preview

#Preview("Large") {
    let style: Style = Style(
        configuration: .init(
            allowNavigationBarTitleAdjustments: true
        )
    )
    
    return NavigationStack {
        StyleScreen {
            Text("Content")
            Text("Content")
            Text("Content")
        }
#if !os(macOS)
        .navigationBarTitleDisplayMode(.large)
#endif
        .navigationTitle("Title")
    }
    .style(fontDesign: .monospaced)
    .styleSetup(style)
}

#Preview("Inline") {
    let style: Style = Style(
        configuration: .init(
            allowNavigationBarTitleAdjustments: true
        )
    )
    
    return NavigationStack {
        StyleScreen {
            Text("Content")
            Text("Content")
            Text("Content")
        }
#if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .navigationTitle("Title")
    }
    .style(fontDesign: .monospaced)
    .styleSetup(style)
}
