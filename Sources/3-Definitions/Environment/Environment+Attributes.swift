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
