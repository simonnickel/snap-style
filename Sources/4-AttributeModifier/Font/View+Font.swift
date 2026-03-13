//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    public func style(font keyPath: Style.Attribute.Font.ValueBuilderKeyPath) -> some View {
        modifier(FontModifier(keyPath: keyPath))
    }

}


// MARK: - Font for Element

extension View {

    public func styleApplyFont(for element: Style.Element.ElementType) -> some View {
        let keyPath = Style.Attribute.Font.environmentKeyPath(for: element)
        return modifier(FontFromEnvironmentModifier(keyPath: keyPath))
    }

    @ViewBuilder
    public func styleSetup(font key: Style.Attribute.Font.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        if let key {
            let keyPath = Style.Attribute.Font.environmentKeyPath(for: element)
            environment(keyPath, key)
        } else {
            self
        }
    }

    @ViewBuilder
    package func setupFonts(for component: Style.Component) -> some View {
        self
            .styleSetup(font: component.fonts?(.any), for: .any)
            .styleSetup(font: component.fonts?(.title), for: .title)
            .styleSetup(font: component.fonts?(.label), for: .label)
            .styleSetup(font: component.fonts?(.icon), for: .icon)
            .styleSetup(font: component.fonts?(.value), for: .value)
            .styleSetup(font: component.fonts?(.accessory), for: .accessory)
            .styleSetup(font: component.fonts?(.separator), for: .separator)
            .styleSetup(font: component.fonts?(.footnote), for: .footnote)
    }

}


// MARK: - Modifier

private struct FontFromEnvironmentModifier: ViewModifier {

    @Environment(\.self) private var environment
    @Environment(\.style) private var style

    let keyPath: KeyPath<EnvironmentValues, Style.Attribute.Font.ValueBuilderKeyPath>

    func body(content: Content) -> some View {
        let key = environment[keyPath: keyPath]
        content
            .modifier(FontModifier(keyPath: key))
    }

}

private struct FontModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Font.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        let properties = style.font(for: keyPath)
        content
            .modifier(ScaledFont(properties: properties))
    }

}

private struct ScaledFont: ViewModifier {
    
    @Environment(\.style) private var style
    
    private let properties: Style.Attribute.Font.Value.Properties?
    private let scaled: ScaledMetric<Double>

    init(properties: Style.Attribute.Font.Value.Properties?) {
        self.properties = properties
        self.scaled = ScaledMetric(wrappedValue: Double(properties?.size ?? .zero), relativeTo: properties?.textStyle ?? .body)
    }
    
    func body(content: Content) -> some View {
        let size = scaled.wrappedValue * style.context.scaleFactor
        let font = properties?.font(size: size)

        return content
            .font(font)
            .fontDesign(properties?.design ?? style.context.fontDesign)
            .fontWidth(properties?.width ?? style.context.fontWidth)
    }
}
