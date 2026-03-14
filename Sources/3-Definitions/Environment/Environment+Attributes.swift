//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI


// MARK: - Protocol

public protocol StyleAttributeEnvironmentKeyPathProvider: StyleAttribute {
    static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath?>
}


// MARK: - EnvironmentValues

extension EnvironmentValues {
    @Entry public var styleFontAny: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontTitle: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontLabel: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontIcon: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontValue: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontAccessory: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontSeparator: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleFontFootnote: Style.Attribute.Font.ValueBuilderKeyPath? = \.anyElement

    @Entry public var styleCompositionAny: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionTitle: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionLabel: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionIcon: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionValue: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionAccessory: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionSeparator: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleCompositionFootnote: Style.Attribute.Composition.ValueBuilderKeyPath? = \.anyElement

    @Entry public var styleShapeAny: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeTitle: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeLabel: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeIcon: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeValue: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeAccessory: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeSeparator: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement
    @Entry public var styleShapeFootnote: Style.Attribute.Shape.ValueBuilderKeyPath? = \.anyElement

    @Entry public var stylePaddingAny: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingTitle: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingLabel: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingIcon: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingValue: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingAccessory: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingSeparator: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
    @Entry public var stylePaddingFootnote: Style.Attribute.Padding.ValueBuilderKeyPath? = \.anyElement
}


// MARK: - Provider

extension Style.Attribute.Font: StyleAttributeEnvironmentKeyPathProvider {

    public static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath?> {
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

extension Style.Attribute.Composition: StyleAttributeEnvironmentKeyPathProvider {

    public static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath?> {
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

extension Style.Attribute.Shape: StyleAttributeEnvironmentKeyPathProvider {

    public static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath?> {
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

extension Style.Attribute.Padding: StyleAttributeEnvironmentKeyPathProvider {

    public static func environmentKeyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath?> {
        switch element {
            case .any: \.stylePaddingAny
            case .title: \.stylePaddingTitle
            case .label: \.stylePaddingLabel
            case .icon: \.stylePaddingIcon
            case .value: \.stylePaddingValue
            case .accessory: \.stylePaddingAccessory
            case .separator: \.stylePaddingSeparator
            case .footnote: \.stylePaddingFootnote
        }
    }
    
}
