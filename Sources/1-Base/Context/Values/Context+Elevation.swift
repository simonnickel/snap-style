//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.Context {
    
    public typealias Elevation = Int

    public static let elevationDefault: Elevation = 0

    public var elevation: Elevation { getValue(for: Self.elevation) ?? Self.elevationDefault }
    
    package static var elevation: Attribute<String, Elevation> { .init(key: "elevation", valueDefault: Self.elevationDefault) }

}


// MARK: - Environment

extension EnvironmentValues {

    @Entry public var styleElevation: Style.Context.Elevation = 0
    
}
