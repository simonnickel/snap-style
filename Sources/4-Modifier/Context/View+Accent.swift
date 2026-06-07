//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapFoundation
import SnapStyleBase

extension View {

    // TODO: Needs inert value
    /// Apply the accent for the `Key` as `.tint` and in `Context`.
    public func style(accent key: Style.Context.Accent.Key) -> some View {
        self
            .modifier(AccentApplyModifier())
            .modifier(AccentKeyModifier(key: key))
    }
    
    /// Set the `Accent` definition for the `Key`.
    public func styleSet(accent accent: Style.Context.Accent, for key: Style.Context.Accent.Key) -> some View {
        self
            .modifier(AccentApplyModifier())
            .modifier(AccentDefinitionModifier(key: key, accent: accent))
    }

}


// MARK: - Modifier

private struct AccentKeyModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let key: Style.Context.Accent.Key
    
    func body(content: Content) -> some View {
        let accent = style.context.accent(for: key)
        let color = accent?.color(in: style) ?? .accentColor
        
        content
            .style(attribute: Style.Context.accent, value: key)
    }
}

private struct AccentDefinitionModifier: ViewModifier {

    @Environment(\.style) private var style

    let key: Style.Context.Accent.Key
    let accent: Style.Context.Accent

    func body(content: Content) -> some View {
        let accents = style.context.accents.updated(key: key, with: accent)
        
        content
            .style(attribute: Style.Context.accents, value: accents)
    }

}

/// Applies the `Accent` as `.tint` by resolving the color for the `Key` set in context.
private struct AccentApplyModifier: ViewModifier {

    @Environment(\.style) private var style

    func body(content: Content) -> some View {
        let color = style.accent.color(in: style)
        
        content
            .tint(color)
    }

}

#Preview {
    VStack {
    
        // This is the intended assignment of an accent.
        Text("Accent assignment")
            // Tell the view to use the accent surface.
            .style(foreground: \.accent)
            // Define which accent key to use in the context (defaults to primary).
            .style(accent: .secondary)
            // Assign an accent to a key (defaults to fallbacks).
            .styleSet(accent: .color(base: .teal, onAccent: .black, complementary: .teal, contrast: .teal, brightness: .light), for: .secondary)

        Text("Primary fallback")
            .style(foreground: \.accent)
        Text("Secondary fallback")
            .style(foreground: \.accentSecondary)
        Text("Destructive fallback")
            .style(foreground: \.accentDestructive)
        
        Text("Custom Color Accent")
            .style(foreground: \.accent)
            .styleSet(accent: .color(base: .orange, onAccent: .black, complementary: .black, contrast: .black, brightness: .light), for: .primary)
            
    }
}
