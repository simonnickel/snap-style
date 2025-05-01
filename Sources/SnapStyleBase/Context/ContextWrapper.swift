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


// MARK: - Modifier

extension View {
    
    /// Update the `SnapStyle` definition in the Environment.
    public func style(update definition: SnapStyle) -> some View {
        self
            .modifier(DefinitionModifier(definition: definition))
    }
    
    /// Update the `Context` in the Environment.
    package func style(update context: SnapStyle.Context) -> some View {
        self
            .modifier(ContextModifier(context: context))
    }
    
}

internal struct DefinitionModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let definition: SnapStyle
    
    func body(content: Content) -> some View {
        content
            .environment(\.style, style.update(definition: definition))
    }
    
}

internal struct ContextModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let context: SnapStyle.Context
    
    func body(content: Content) -> some View {
        content
            .environment(\.style, style.update(context: context))
    }
    
}


// MARK: - Environment

extension EnvironmentValues {
    
    @Entry public var style: SnapStyle.ContextWrapper = .init(definition: .init(), context: .init())
    
}
