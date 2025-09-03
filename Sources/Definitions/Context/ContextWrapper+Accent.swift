//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension SnapStyle.ContextWrapper {

    public var accent: SnapStyle.AccentKey.Value.WrappedValue {
        if context.component.useSecondaryAccent {
            accent(for: \.secondary) ?? .fallbackSecondary
        } else {
            if let accentKeypath = context.accent {
                accent(for: accentKeypath) ?? .fallbackPrimary
            } else {
                accent(for: \.primary) ?? .fallbackPrimary
            }
        }
    }
    
    public var accentPrimary: SnapStyle.AccentKey.Value.WrappedValue {
        accent(for: \.primary) ?? .fallbackPrimary
    }

}


// MARK: - Modifier

extension View {

    public func style(accent: SnapStyle.AccentKey.ValueBuilderKeyPath) -> some View {
        style(attribute: SnapStyle.Context.accent, value: accent)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public var accent: SnapStyle.AccentKey.ValueBuilderKeyPath? { getValue(for: Self.accent) }

    public static var accent: Attribute<String, SnapStyle.AccentKey.ValueBuilderKeyPath> { .init(key: "Accent", valueDefault: nil) }

}
