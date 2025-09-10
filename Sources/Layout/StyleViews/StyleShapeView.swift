//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleShapeView: View {

    @Environment(\.style) private var style

    let shape: Style.ShapeKey.Value
    let surface: Style.SurfaceKey.ValueBuilderKeyPath

    public init(shape: Style.ShapeKey.Value, surface: Style.SurfaceKey.ValueBuilderKeyPath) {
        self.shape = shape
        self.surface = surface
    }

    public var body: some View {
        let value = style.surface(for: surface)
        AnyShape(
            shape.shape(with: style)
        )
        .fill(value?.anyShapeStyle ?? AnyShapeStyle(.clear))
    }

}

#Preview {
    StyleShapeView(shape: .capsule, surface: \.accent)
        .frame(width: 200, height: 100)
    StyleShapeView(shape: .circle, surface: \.accent)
        .frame(width: 200, height: 100)
    StyleShapeView(shape: .rectangle, surface: \.accent)
        .frame(width: 200, height: 100)
}
