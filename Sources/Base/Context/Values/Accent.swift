//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

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
        public let accent: SnapStyle.Accent
        public let alternative: SnapStyle.Accent

        public init(_ accent: SnapStyle.Accent, _ alternative: SnapStyle.Accent) {
            self.accent = accent
            self.alternative = alternative
        }
    }

}


// MARK: - Modifier

extension View {

    // TODO: Should this use Accent.Pair?
    public func style(accent: SnapStyle.Accent, alternative: SnapStyle.Accent? = nil) -> some View {
        modifier(UpdateAccentModifier(accent: accent, alternative: alternative))
    }

}

internal struct UpdateAccentModifier: ViewModifier {

    @Environment(\.style) private var style

    let accent: SnapStyle.Accent
    let alternative: SnapStyle.Accent?

    func body(content: Content) -> some View {
        content
            .accentColor(accent.base)
            .style(attribute: SnapStyle.Context.accent, value: accent)
            .if(unwrap: alternative, transform: { content, alternative in
                content
                    .style(attribute: SnapStyle.Context.accentAlternative, value: alternative)
            })
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public var accent: SnapStyle.Accent { getValue(for: Self.accent) ?? SnapStyle.Accent.fallback }
    public static var accent: Attribute<String, SnapStyle.Accent> { .init(key: "accent", valueDefault: SnapStyle.Accent.fallback) }

    public var accentAlternative: SnapStyle.Accent { getValue(for: Self.accentAlternative) ?? SnapStyle.Accent.fallback }
    public static var accentAlternative: Attribute<String, SnapStyle.Accent> { .init(key: "accentAlternative", valueDefault: SnapStyle.Accent.fallbackAlternative) }

}
