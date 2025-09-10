//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(font keyPath: Style.FontKey.ValueBuilderKeyPath) -> some View {
        modifier(FontModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

private struct FontModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.FontKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        let definition = style.font(for: keyPath)
        content
            .modifier(ScaledFont(definition: definition))
    }

}

private struct ScaledFont: ViewModifier {
    
    @Environment(\.style) private var style
    
    private let definition: Style.FontKey.Value.Definition?
    private let scaled: ScaledMetric<Double>

    init(definition: Style.FontKey.Value.Definition?) {
        self.definition = definition
        self.scaled = ScaledMetric(wrappedValue: Double(definition?.size ?? .zero), relativeTo: definition?.textStyle ?? .body)
    }
    
    func body(content: Content) -> some View {
        let size = scaled.wrappedValue * style.context.scaleFactor
        let font = definition?.font(size: size)

        return content
            .font(font)
            .fontDesign(definition?.design ?? style.context.fontDesign)
            .fontWidth(definition?.width ?? style.context.fontWidth)
    }
}
