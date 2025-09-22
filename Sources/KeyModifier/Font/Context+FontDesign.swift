//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI


// MARK: - Modifier

extension View {

    /// Sets the `Font.Design`, inert value: `.default`.
    public func style(fontDesign: Font.Design = Style.Context.fontDesignDefault) -> some View {
        self
            .style(attribute: Style.Context.fontDesign, value: fontDesign)
    }

}


// MARK: - Context

extension Style.Context {

    public static let fontDesignDefault: Font.Design = .default

    public var fontDesign: Font.Design { getValue(for: Self.fontDesign) ?? Self.fontDesignDefault }

    public static var fontDesign: Attribute<String, Font.Design> { .init(key: "FontDesign", valueDefault: Self.fontDesignDefault) }

}
