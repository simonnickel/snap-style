//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI


// MARK: - Modifier

extension View {

    public func style(fontWidth: Font.Width?) -> some View {
        modifier(FontWidthModifier(fontWidth: fontWidth))
    }

}

internal struct FontWidthModifier: ViewModifier {

    let fontWidth: Font.Width?

    func body(content: Content) -> some View {
        content
            .style(attribute: SnapStyle.Context.fontWidth, value: fontWidth)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public static let fontWidthDefault: Font.Width? = nil

    public var fontWidth: Font.Width? { getValue(for: Self.fontWidth) ?? Self.fontWidthDefault }

    public static var fontWidth: Attribute<String, Font.Width?> { .init(key: "FontWidth", valueDefault: Self.fontWidthDefault) }

}
