//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {

    /// A bundle of `Definition` (aka `SnapStyle`) and `Context` to use in Views via the Environment.
    /// The `definition` contains the value generation logic and caches. It needs the `context` to produce the output.
    /// They are bundled to simplify value access by accessing a single entry from the environment.
    public struct ContextWrapper {

        package var definition: SnapStyle
        package var context: SnapStyle.Context

        internal func updated(with context: SnapStyle.Context) -> Self {
            var copy = self
            copy.context = context
            return copy
        }

        internal func updated(with definition: SnapStyle) -> Self {
            var copy = self
            copy.definition = definition
            return copy
        }

    }

}


// MARK: - Environment

extension EnvironmentValues {

    @Entry public var style: SnapStyle.ContextWrapper = .init(definition: .init(), context: .init())

}
