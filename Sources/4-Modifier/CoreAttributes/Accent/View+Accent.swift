//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions


// MARK: - Modifier

extension View {

    public func style(accent: Style.Attribute.Accent.ValueBuilderKeyPath?) -> some View {
        self
            .modifier(AccentKeyPathModifier(keyPath: accent))
    }
    
    public func style(accent: Style.Attribute.Accent.Value.WrappedValue) -> some View {
        self
            .modifier(AccentValueModifier(value: accent))
    }

}


// MARK: - Modifier

private struct AccentKeyPathModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Accent.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        if
            let keyPath,
            let value = style.accentValue(for: keyPath)
        {
            content
                .modifier(AccentValueModifier(value: value))
        } else {
            content
        }
    }

}

private struct AccentValueModifier: ViewModifier {

    @Environment(\.style) private var style

    let value: Style.Attribute.Accent.Value.WrappedValue

    func body(content: Content) -> some View {
        let color = value.color(in: style)
        content
        // TODO: .accentColor() is deprecated, but I think this is used in the definitions to get the system defined tint color. Need to check and replace. Also check other uses of .accentColor.
        // TODO: Should this always be set or just for primary?
            .accentColor(color)
            .tint(color)
//            .accentColor(keyPath == \.primary ? color : nil)
//            .tint(keyPath == \.primary ? color : nil)
            .style(attribute: Style.Context.accent, value: value)
    }

}

#Preview {
    VStack {
        
        Text("Hello, World!")
            .style(foreground: \.accent)
            .style(accent: \.teal)
        
        Text("Hello, World!")
            .style(foreground: \.accent)
            .style(accent: .color(base: .orange, onAccent: .black, complementary: .black, contrast: .black, brightness: .light))
            
    }
}
