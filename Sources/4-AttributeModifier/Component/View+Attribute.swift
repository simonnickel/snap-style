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
        let key = environment[keyPath: keyPath]

        switch key {
            
            case let kp as KeyPath<Style.Attribute.Font, Style.Attribute.Font.ValueBuilder>:
                content.modifier(FontModifier(keyPath: kp))
            
            case let kp as KeyPath<Style.Attribute.Composition, Style.Attribute.Composition.ValueBuilder>:
                content.modifier(CompositionModifier(keyPath: kp, layers: Style.Attribute.Composition.Layer.allCases, ignoresSafeAreaEdges: []))
            
            case let kp as KeyPath<Style.Attribute.Shape, Style.Attribute.Shape.ValueBuilder>:
                content.modifier(ShapeAttributeModifier(keyPath: kp, shouldClip: false))
            
            default: content
            
        }
    }
    
}
