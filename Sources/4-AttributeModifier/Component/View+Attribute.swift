//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

extension View {
    
    /// Apply the attribute for the element defined in the environment.
    public func style<Attribute: StyleAttributeEnvironmentKeyPathProvider>(apply: Attribute.Type, for element: Style.Element.ElementType) -> some View {
        return modifier(AttributeFromEnvironmentModifier<Attribute>(element: element))
    }
    
    /// Define a value of an attribute for an element in the environment.
    @ViewBuilder
    public func style<Attribute: StyleAttributeEnvironmentKeyPathProvider>(define: Attribute.Type, key: Attribute.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        if let key {
            let keyPath = Attribute.environmentKeyPath(for: element)
            environment(keyPath, key)
        } else {
            self
        }
    }
    
}
    
private struct AttributeFromEnvironmentModifier<Attribute: StyleAttributeEnvironmentKeyPathProvider>: ViewModifier {
    
    @Environment(\.self) private var environment
    @Environment(\.style) private var style
    
    let element: Style.Element.ElementType
    
    func body(content: Content) -> some View {
        let keyPath = Attribute.environmentKeyPath(for: element)

        // Type-erase to AnyKeyPath so the cast inside each metatype branch doesn't trigger compiler warnings.
        let key: AnyKeyPath = environment[keyPath: keyPath]

        switch Attribute.self {

            case is Style.Attribute.Font.Type:
                if let fontKey = key as? Style.Attribute.Font.ValueBuilderKeyPath {
                    content.modifier(FontModifier(keyPath: fontKey))
                } else { content }

            case is Style.Attribute.Composition.Type:
                if let compositionKey = key as? Style.Attribute.Composition.ValueBuilderKeyPath {
                    content.modifier(CompositionModifier(keyPath: compositionKey, layers: Style.Attribute.Composition.Layer.allCases, ignoresSafeAreaEdges: []))
                } else { content }

            case is Style.Attribute.Shape.Type:
                content.modifier(ShapeAttributeModifier(keyPath: key as? Style.Attribute.Shape.ValueBuilderKeyPath, shouldClip: false))

            default: content

        }
    }
    
}
