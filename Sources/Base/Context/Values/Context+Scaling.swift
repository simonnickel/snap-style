//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI


// MARK: - Modifier

extension View {

    public func style(scaleFactor: SnapStyle.Context.ScaleFactor? = nil) -> some View {
        self
            .style(attribute: SnapStyle.Context.scaleFactor, value: scaleFactor ?? SnapStyle.Context.scaleFactorDefault)
    }

}


// MARK: - Context

extension SnapStyle.Context {

    public typealias ScaleFactor = SnapStyle.NumberKey.Value.WrappedValue

    public static let scaleFactorDefault: ScaleFactor = 1.0

    public var scaleFactor: ScaleFactor { getValue(for: Self.scaleFactor) ?? Self.scaleFactorDefault }

    public static var scaleFactor: Attribute<String, ScaleFactor> { .init(key: "ScaleFactor", valueDefault: Self.scaleFactorDefault) }

}
