//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    // TODO: Could be moved to AccentKey.
    // TODO: Could hold ValueBuilderKeyPath instead of Color (see stash).
    public struct Accent: Hashable, Equatable {
        public let base: Color
        public let onAccent: Color
        public let complementary: Color
        public let contrast: Color
        public let brightness: Brightness

        public enum Brightness {
            case light, dark
        }

        public init(base: Color, onAccent: Color, complementary: Color, contrast: Color, brightness: Brightness) {
            self.base = base
            self.onAccent = onAccent
            self.complementary = complementary
            self.contrast = contrast
            self.brightness = brightness
        }

        public static var fallback: Self {
            Accent(
                base: Color.accentColor,
                onAccent: Color.white,
                complementary: Color.accentColor.mix(with: .white, by: 0.2),
                contrast: Color.accentColor.mix(with: .black, by: 0.2),
                brightness: .dark
            )
        }
        
        public static var fallbackAlternative: Self {
            Accent(
                base: Color.black,
                onAccent: Color.white,
                complementary: Color.gray,
                contrast: Color.white,
                brightness: .dark
            )
        }
    }

}


// MARK: - Pair

extension SnapStyle.Accent {
    
    public struct Pair: Hashable, Equatable {
        public let primary: SnapStyle.Accent
        public let secondary: SnapStyle.Accent

        public init(_ accent: SnapStyle.Accent, _ alternative: SnapStyle.Accent) {
            self.primary = accent
            self.secondary = alternative
        }
        
        public static var fallback: Self {
            Pair(.fallback, .fallbackAlternative)
        }
    }

}


// MARK: - Modifier

extension View {

    public func style(accents: SnapStyle.Accent.Pair) -> some View {
        modifier(UpdateAccentModifier(accents: accents))
    }

}

internal struct UpdateAccentModifier: ViewModifier {

    @Environment(\.style) private var style

    let accents: SnapStyle.Accent.Pair

    func body(content: Content) -> some View {
        content
            .accentColor(accents.primary.base)
            .style(attribute: SnapStyle.Context.accentPrimary, value: accents.primary)
            .style(attribute: SnapStyle.Context.accentSecondary, value: accents.secondary)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public var accentPrimary: SnapStyle.Accent { getValue(for: Self.accentPrimary) ?? SnapStyle.Accent.fallback }
    public static var accentPrimary: Attribute<String, SnapStyle.Accent> { .init(key: "accentPrimary", valueDefault: SnapStyle.Accent.fallback) }

    public var accentSecondary: SnapStyle.Accent { getValue(for: Self.accentSecondary) ?? SnapStyle.Accent.fallback }
    public static var accentSecondary: Attribute<String, SnapStyle.Accent> { .init(key: "accentSecondary", valueDefault: SnapStyle.Accent.fallbackAlternative) }

}
