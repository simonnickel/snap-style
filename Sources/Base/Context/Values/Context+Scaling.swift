//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI


// MARK: - Modifier

extension View {

    public func style(scaleFactor: Style.Context.ScaleFactor? = nil) -> some View {
        self
            .style(attribute: Style.Context.scaleFactor, value: scaleFactor ?? Style.Context.scaleFactorDefault)
    }

}


// MARK: - Context

extension Style.Context {

    public typealias ScaleFactor = Style.Keys.Number.Value.WrappedValue

    public static let scaleFactorDefault: ScaleFactor = 1.0

    public var scaleFactor: ScaleFactor { getValue(for: Self.scaleFactor) ?? Self.scaleFactorDefault }

    public static var scaleFactor: Attribute<String, ScaleFactor> { .init(key: "ScaleFactor", valueDefault: Self.scaleFactorDefault) }

}
