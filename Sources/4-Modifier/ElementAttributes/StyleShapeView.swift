//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleShapeView: View {

    @Environment(\.style) private var style

    let keyPathShape: Style.Attribute.Shape.ValueBuilderKeyPath
    let keyPathSurface: Style.Attribute.Surface.ValueBuilderKeyPath?
    let keyPathBorderSurface: Style.Attribute.Surface.ValueBuilderKeyPath?
    let keyPathBorderWidth: Style.Attribute.Number.ValueBuilderKeyPath?

    public init(
        shape: Style.Attribute.Shape.ValueBuilderKeyPath,
        surface: Style.Attribute.Surface.ValueBuilderKeyPath? = nil,
        border: Style.Attribute.Surface.ValueBuilderKeyPath? = nil,
        width: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
    ) {
        self.keyPathShape = shape
        self.keyPathSurface = surface
        self.keyPathBorderSurface = border
        self.keyPathBorderWidth = width
    }

    public var body: some View {
        let shape = style.shape(for: keyPathShape)
        let surface = style.surface(for: keyPathSurface)
        let surfaceBorder = style.surface(for: keyPathBorderSurface)
        let borderWidth = style.number(for: keyPathBorderWidth)
        
        let border: AnyShapeStyle = AnyShapeStyle(
            surfaceBorder?.anyShapeStyle ?? AnyShapeStyle(Color.clear)
        )
        
        if let shape {
            AnyShape(
                shape.shape(with: style)
            )
            .fill(surface?.anyShapeStyle ?? AnyShapeStyle(.clear))
            .stroke(border, lineWidth: borderWidth ?? 0)
        }
    }

}

#Preview {
    StyleShapeView(shape: \.capsule, surface: \.accent, border: \.snapBlack)
        .frame(width: 200, height: 100)
    StyleShapeView(shape: \.circle, surface: \.accent)
        .frame(width: 200, height: 100)
    StyleShapeView(shape: \.rectangle, surface: \.accent)
        .frame(width: 200, height: 100)
}
