//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle.Context {
    
    public var colorScheme: ColorScheme { getValue(for: Self.colorScheme) ?? .light }
    package static var colorScheme: Attribute<String, ColorScheme> { .init(key: "colorScheme", valueDefault: nil) }
    
}
