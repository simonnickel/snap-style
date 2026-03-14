//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

extension View {
    
    /// Define a value of an attribute for an element in the environment.
    @ViewBuilder
    public func style<Attribute: StyleElementAttribute>(
        define: Attribute.Type,
        key: Attribute.ValueBuilderKeyPath?,
        for element: Style.Element.ElementType,
        shouldClear: Bool = false,
    ) -> some View {
        let keyPath = Attribute.environmentKeyPath(for: element)
        modifier(UpdateEnvironmentModifier(keyPathEnvironment: keyPath, keyPathValueBuilder: key, shouldClear: shouldClear))
    }
    
}

/// Sets a `ValueBuilder` in the `Environment` for the given `KeyPath`.
/// `shouldClear` controls wether a nil value resets or uses the value from environment.
private struct UpdateEnvironmentModifier<Attribute: StyleElementAttribute>: ViewModifier {
    
    @Environment(\.self) private var environment
    
    let keyPathEnvironment: WritableKeyPath<EnvironmentValues, Attribute.ValueBuilderKeyPath?>
    let keyPathValueBuilder: Attribute.ValueBuilderKeyPath?
    let shouldClear: Bool
    
    func body(content: Content) -> some View {
        let value = keyPathValueBuilder ?? (shouldClear ? nil : environment[keyPath: keyPathEnvironment])
        content
            .environment(keyPathEnvironment, value)
    }
    
}
