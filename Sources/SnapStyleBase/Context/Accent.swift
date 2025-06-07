//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    public struct Accent: Hashable, Equatable {
        public let base: Color
        public let complementary: Color
        public let contrast: Color
        public let brightness: Brightness

        public enum Brightness {
            case light, dark
        }

        public init(base: Color, complementary: Color, contrast: Color, brightness: Brightness) {
            self.base = base
            self.complementary = complementary
            self.contrast = contrast
            self.brightness = brightness
        }

        public static var fallback: Self {
            Accent(
                base: Color.accentColor,
                complementary: Color.accentColor.mix(with: .white, by: 0.2),
                contrast: Color.accentColor.mix(with: .black, by: 0.2),
                brightness: .dark
            )
        }
    }

}


// MARK: - Modifier

extension View {

    public func style(accent: SnapStyle.Accent) -> some View {
        self
            .modifier(UpdateAccentModifier(accent: accent))
    }

}

internal struct UpdateAccentModifier: ViewModifier {

    @Environment(\.style) private var style

    let accent: SnapStyle.Accent

    func body(content: Content) -> some View {
        content
            .tint(accent.base)
            .style(attribute: SnapStyle.Context.accent, value: accent)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public var accent: SnapStyle.Accent { getValue(for: Self.accent) ?? SnapStyle.Accent.fallback }

    public static var accent: Attribute<String, SnapStyle.Accent> { .init(key: "accent", valueDefault: SnapStyle.Accent.fallback) }

}
