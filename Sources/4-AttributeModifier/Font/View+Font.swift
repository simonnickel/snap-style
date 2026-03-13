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
    
    /// Convenience shortcut to define a `Font` for an element via environment.
    public func styleDefine(font key: Style.Attribute.Font.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        style(define: Style.Attribute.Font.self, key: key, for: element)
    }

}


// MARK: - Modifier

package struct FontModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Font.ValueBuilderKeyPath

    package func body(content: Content) -> some View {
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
