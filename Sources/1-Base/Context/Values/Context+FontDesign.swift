//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.Context {

    public static let fontDesignDefault: Font.Design = .default

    public var fontDesign: Font.Design { getValue(for: Self.fontDesign) ?? Self.fontDesignDefault }

    public static var fontDesign: Attribute<String, Font.Design> { .init(key: "FontDesign", valueDefault: Self.fontDesignDefault) }

}
