//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI


// MARK: - Modifier

extension View {

    public func style(fontDesign: Font.Design?) -> some View {
        self
            .style(attribute: SnapStyle.Context.fontDesign, value: fontDesign)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public static let fontDesignDefault: Font.Design? = nil

    public var fontDesign: Font.Design? { getValue(for: Self.fontDesign) ?? Self.fontDesignDefault }

    public static var fontDesign: Attribute<String, Font.Design?> { .init(key: "FontDesign", valueDefault: Self.fontDesignDefault) }

}
