//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions


// MARK: - Modifier

extension View {
    
    // TODO: Enum for .primary, .secondary, .destructive

    public func style(accent: Style.Context.Accent) -> some View {
        self
            .modifier(AccentValueModifier(value: accent))
    }
    
    public func style(accentSecondary: Style.Context.Accent) -> some View {
        self
            .modifier(AccentValueSecondaryModifier(value: accentSecondary))
    }

}


// MARK: - Modifier

private struct AccentValueModifier: ViewModifier {

    @Environment(\.style) private var style

    let value: Style.Context.Accent

    func body(content: Content) -> some View {
        let color = value.color(in: style)
        content
        // TODO: .accentColor() is deprecated, but I think this is used in the definitions to get the system defined tint color. Need to check and replace. Also check other uses of .accentColor.
            .accentColor(color)
            .tint(color)
            .style(attribute: Style.Context.accentPrimary, value: value)
    }

}

private struct AccentValueSecondaryModifier: ViewModifier {

    @Environment(\.style) private var style

    let value: Style.Context.Accent

    func body(content: Content) -> some View {
        content
            .style(attribute: Style.Context.accentSecondary, value: value)
    }

}

#Preview {
    VStack {
        
        Text("Hello, World!")
            .style(foreground: \.accent)
            .style(accent: .teal)
        
        Text("Hello, World!")
            .style(foreground: \.accent)
            .style(accent: .color(base: .orange, onAccent: .black, complementary: .black, contrast: .black, brightness: .light))
            
    }
}
