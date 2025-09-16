//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

// TODO: Should this be in Core?

public extension EnvironmentValues {
    @Entry public var enabled: Bool = true
}

extension View {
    public func style(enabled: Bool) -> some View {
        environment(\.enabled, enabled)
    }
}
