//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI


// MARK: - Modifier

extension View {

    public func style(fontWidth: Font.Width?) -> some View {
        self
            .style(attribute: Style.Context.fontWidth, value: fontWidth)
    }

}


// MARK: - Context

extension Style.Context {

    public static let fontWidthDefault: Font.Width? = nil

    public var fontWidth: Font.Width? { getValue(for: Self.fontWidth) ?? Self.fontWidthDefault }

    public static var fontWidth: Attribute<String, Font.Width?> { .init(key: "FontWidth", valueDefault: Self.fontWidthDefault) }

}
