//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

extension View {
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
                .modifier(StyleNavigationBarScaledModifier(definitionInline: definitionInline, definitionLarge: definitionLarge))
#endif
        } else {
            content
        }
    }
}


// MARK: - StyleNavigationBarScaledModifier

private struct StyleNavigationBarScaledModifier: ViewModifier {

    @Environment(\.style) private var style
    
    private let definitionInline: SnapStyle.FontKey.Value.Definition
    private let definitionLarge: SnapStyle.FontKey.Value.Definition
    private let scaledInline: ScaledMetric<Double>
    private let scaledLarge: ScaledMetric<Double>
    
    init(definitionInline: SnapStyle.FontKey.Value.Definition, definitionLarge: SnapStyle.FontKey.Value.Definition) {
        self.definitionInline = definitionInline
        self.definitionLarge = definitionLarge
        self.scaledInline = ScaledMetric(wrappedValue: definitionInline.size, relativeTo: definitionInline.textStyle)
        self.scaledLarge = ScaledMetric(wrappedValue: definitionLarge.size, relativeTo: definitionLarge.textStyle)
    }
    
    @State private var navigationBar: UINavigationBar?

    func body(content: Content) -> some View {
        content
#if canImport(UIKit)
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
#endif
    }
    
#if canImport(UIKit)
    
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
        with style: SnapStyle.ContextWrapper,
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
        for keyPath: SnapStyle.FontKey.ValueBuilderKeyPath,
        with style: SnapStyle.ContextWrapper,
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
    NavigationStack {
        StyleScreen {
            Text("Content")
            Text("Content")
            Text("Content")
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Title")
    }
    .style(fontDesign: .monospaced)
}

#Preview("Inline") {
    NavigationStack {
        StyleScreen {
            Text("Content")
            Text("Content")
            Text("Content")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Title")
    }
    .style(fontDesign: .monospaced)
}
