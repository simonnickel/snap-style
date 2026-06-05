//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapFoundation
import SnapStyleBase
import SnapStyleDefinitions


// MARK: - Modifier

extension View {
    
    // TODO: Enum for .primary, .secondary, .destructive

    public func style(accent accent: Style.Context.Accent, for key: Style.Context.Accent.Key = .primary) -> some View {
        self
            .modifier(AccentValueModifier(key: key, accent: accent))
    }

}


// MARK: - Modifier

private struct AccentValueModifier: ViewModifier {

    @Environment(\.style) private var style

    let key: Style.Context.Accent.Key
    let accent: Style.Context.Accent

    func body(content: Content) -> some View {
        let color = accent.color(in: style)
        let accents = style.context.accents.updated(key: key, with: accent)
        
        content
        // TODO: .accentColor() is deprecated, but I think this is used in the definitions to get the system defined tint color. Need to check and replace. Also check other uses of .accentColor.
            .accentColor(color)
            .tint(color)
            .style(attribute: Style.Context.accents, value: accents)
    }

}

#Preview {
    VStack {
        
        Text("Primary fallback")
            .style(foreground: \.accent)
        Text("Secondary fallback")
            .style(foreground: \.accentSecondary)
        Text("Destructive fallback")
            .style(foreground: \.accentDestructive)
        
        Text("Accent Override")
            .style(foreground: \.accent)
            .style(accent: .teal, for: .primary)
        
        Text("Custom Color Accent")
            .style(foreground: \.accent)
            .style(accent: .color(base: .orange, onAccent: .black, complementary: .black, contrast: .black, brightness: .light))
            
    }
}
