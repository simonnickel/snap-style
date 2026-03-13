//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension EnvironmentValues {
    @Entry public var styleFontAny: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontTitle: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontLabel: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontIcon: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontValue: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontAccessory: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontSeparator: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontFootnote: Style.Attribute.Font.ValueBuilderKeyPath = \.anyElement

    @Entry public var styleCompositionAny: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionTitle: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionLabel: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionIcon: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionValue: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionAccessory: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionSeparator: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionFootnote: Style.Attribute.Composition.ValueBuilderKeyPath = \.anyElement

    @Entry public var styleShapeAny: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeTitle: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeLabel: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeIcon: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeValue: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeAccessory: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeSeparator: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleShapeFootnote: Style.Attribute.Shape.ValueBuilderKeyPath = \.anyElement
}

extension Style.Attribute.Font {

    package static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath> {
        switch element {
            case .any: \.styleFontAny
            case .title: \.styleFontTitle
            case .label: \.styleFontLabel
            case .icon: \.styleFontIcon
            case .value: \.styleFontValue
            case .accessory: \.styleFontAccessory
            case .separator: \.styleFontSeparator
            case .footnote: \.styleFontFootnote
        }
    }
    
}

extension Style.Attribute.Composition {

    package static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath> {
        switch element {
            case .any: \.styleCompositionAny
            case .title: \.styleCompositionTitle
            case .label: \.styleCompositionLabel
            case .icon: \.styleCompositionIcon
            case .value: \.styleCompositionValue
            case .accessory: \.styleCompositionAccessory
            case .separator: \.styleCompositionSeparator
            case .footnote: \.styleCompositionFootnote
        }
    }
    
}

extension Style.Attribute.Shape {

    package static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath> {
        switch element {
            case .any: \.styleShapeAny
            case .title: \.styleShapeTitle
            case .label: \.styleShapeLabel
            case .icon: \.styleShapeIcon
            case .value: \.styleShapeValue
            case .accessory: \.styleShapeAccessory
            case .separator: \.styleShapeSeparator
            case .footnote: \.styleShapeFootnote
        }
    }
    
}
