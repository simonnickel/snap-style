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
        
        internal func update(context: SnapStyle.Context) -> Self {
            var result = self
            result.context = context
            return result
        }
        
        internal func update(definition: SnapStyle) -> Self {
            var result = self
            result.definition = definition
            return result
        }
        
    }

}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry public var style: SnapStyle.ContextWrapper = .init(definition: .init(), context: .init())
    
}
