//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension EnvironmentValues {
    @Entry public var styleFontAny: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontTitle: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontLabel: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontIcon: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontValue: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontAccessory: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontSeparator: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleFontFootnote: Style.Attributes.Font.ValueBuilderKeyPath = \.anyElement

    @Entry public var styleCompositionAny: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionTitle: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionLabel: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionIcon: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionValue: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionAccessory: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionSeparator: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
    @Entry public var styleCompositionFootnote: Style.Attributes.Composition.ValueBuilderKeyPath = \.anyElement
}

extension Style.Attributes.Font {

    package static func keyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath> {
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

extension Style.Attributes.Composition {

    package static func keyPath(for element: Style.Element.ElementType) -> WritableKeyPath<EnvironmentValues, ValueBuilderKeyPath> {
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
