//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

// Elevation is provided from the outside via Environment.
// Each Screen has to translate the environment into Context

extension View {
    
    /// Elevation is provided from outside of SnapStyle via the Environment (`\.styleElevation`) and has to be forwarded into the `Context`.
    public func styleElevationRelay() -> some View {
        self
            .modifier(ElevationRelayModifier())
    }
    
}

private struct ElevationRelayModifier: ViewModifier {
    
    @Environment(\.styleElevation) private var elevation
    
    func body(content: Content) -> some View {
        content
            .style(attribute: Style.Context.elevation, value: elevation)
    }
    
}


// MARK: - Context

extension Style.Context {
    
    public typealias Elevation = Int

    public static let elevationDefault: Elevation = 0

    public var elevation: Elevation { getValue(for: Self.elevation) ?? Self.elevationDefault }
    
    package static var elevation: Attribute<String, Elevation> { .init(key: "elevation", valueDefault: Self.elevationDefault) }

}


// MARK: - Environment

extension EnvironmentValues {

    @Entry public var styleElevation: Style.Context.Elevation = 0
    
}
