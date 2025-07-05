//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func styleOverride(
        numbers: [SnapStyle.NumberKey.ValueBuilderKeyPath: SnapStyle.NumberKey.ValueBuilder]? = nil,
        fonts: [SnapStyle.FontKey.ValueBuilderKeyPath: SnapStyle.FontKey.ValueBuilder]? = nil,
        icons: [SnapStyle.IconKey.ValueBuilderKeyPath: SnapStyle.IconKey.ValueBuilder]? = nil,
        surfaces: [SnapStyle.SurfaceKey.ValueBuilderKeyPath: SnapStyle.SurfaceKey.ValueBuilder]? = nil,
        compositions: [SnapStyle.CompositionKey.ValueBuilderKeyPath: SnapStyle.CompositionKey.ValueBuilder]? = nil,
        shapes: [SnapStyle.ShapeKey.ValueBuilderKeyPath: SnapStyle.ShapeKey.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            StyleOverrideModifier(
                numbers: numbers,
                fonts: fonts,
                icons: icons,
                surfaces: surfaces,
                compositions: compositions,
                shapes: shapes
            )
        )
    }

}


// MARK: - Modifier

private struct StyleOverrideModifier: ViewModifier {

    @Environment(\.style) private var style

    let numbers: [SnapStyle.NumberKey.ValueBuilderKeyPath: SnapStyle.NumberKey.ValueBuilder]?
    let fonts: [SnapStyle.FontKey.ValueBuilderKeyPath: SnapStyle.FontKey.ValueBuilder]?
    let icons: [SnapStyle.IconKey.ValueBuilderKeyPath: SnapStyle.IconKey.ValueBuilder]?
    let surfaces: [SnapStyle.SurfaceKey.ValueBuilderKeyPath: SnapStyle.SurfaceKey.ValueBuilder]?
    let compositions: [SnapStyle.CompositionKey.ValueBuilderKeyPath: SnapStyle.CompositionKey.ValueBuilder]?
    let shapes: [SnapStyle.ShapeKey.ValueBuilderKeyPath: SnapStyle.ShapeKey.ValueBuilder]?

    func body(content: Content) -> some View {

        let definition = style.definition.replaced(
            numbers: numbers,
            fonts: fonts,
            icons: icons,
            surfaces: surfaces,
            compositions: compositions,
            shapes: shapes
        )

        content
            .style(update: definition)

    }

}


// MARK: - SnapStyle: replaced

extension SnapStyle {

    internal func replaced(
        numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]? = nil,
        fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]? = nil,
        icons: [IconKey.ValueBuilderKeyPath: IconKey.ValueBuilder]? = nil,
        surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]? = nil,
        compositions: [CompositionKey.ValueBuilderKeyPath: CompositionKey.ValueBuilder]? = nil,
        shapes: [ShapeKey.ValueBuilderKeyPath: ShapeKey.ValueBuilder]? = nil
    ) -> Self {
        var style = self

        if let numbers {
            style = style.appended(numbers: numbers)
        }

        if let fonts {
            style = style.appended(fonts: fonts)
        }

        if let icons {
            style = style.appended(icons: icons)
        }

        if let surfaces {
            style = style.appended(surfaces: surfaces)
        }

        if let compositions {
            style = style.appended(compositions: compositions)
        }

        if let shapes {
            style = style.appended(shapes: shapes)
        }

        return style
    }

}
