//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(font keyPath: SnapStyle.FontKey.ValueBuilderKeyPath) -> some View {
        modifier(FontModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

struct FontModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.FontKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if let definition = style.font(for: keyPath) {
            content
                .modifier(ScaledFont(definition: definition))
        } else {
            content
        }
    }

}

struct ScaledFont: ViewModifier {
    
    @Environment(\.style) private var style
    
    private let definition: SnapStyle.FontKey.Value.Definition
    private let scaled: ScaledMetric<Double>
    
    init(definition: SnapStyle.FontKey.Value.Definition) {
        self.definition = definition
        self.scaled = ScaledMetric(wrappedValue: definition.size, relativeTo: definition.textStyle)
    }
    
    func body(content: Content) -> some View {
        let size = scaled.wrappedValue * style.context.scaleFactor
        let font = definition.font(size: size)

        return content
            .font(font)
            .fontDesign(definition.design ?? style.context.fontDesign)
            .fontWidth(definition.width ?? style.context.fontWidth)
    }
}
