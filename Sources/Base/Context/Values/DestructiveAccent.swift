//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI


// MARK: - Modifier

extension View {

    public func styleDestructive() -> some View {
        modifier(DestructiveAccentModifier())
    }

}

internal struct DestructiveAccentModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .style(attribute: SnapStyle.Context.destructiveAccent, value: true)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public static let destructiveAccentDefault: Bool = false

    public var destructiveAccent: Bool { getValue(for: Self.destructiveAccent) ?? Self.destructiveAccentDefault }

    public static var destructiveAccent: Attribute<String, Bool> { .init(key: "DestructiveAccent", valueDefault: Self.destructiveAccentDefault) }

}
