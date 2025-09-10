//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func styleOverride(
        numbers: [Style.NumberKey.ValueBuilderKeyPath: Style.NumberKey.ValueBuilder]? = nil,
        fonts: [Style.FontKey.ValueBuilderKeyPath: Style.FontKey.ValueBuilder]? = nil,
        icons: [Style.IconKey.ValueBuilderKeyPath: Style.IconKey.ValueBuilder]? = nil,
        surfaces: [Style.SurfaceKey.ValueBuilderKeyPath: Style.SurfaceKey.ValueBuilder]? = nil,
        compositions: [Style.CompositionKey.ValueBuilderKeyPath: Style.CompositionKey.ValueBuilder]? = nil,
        accents: [Style.AccentKey.ValueBuilderKeyPath: Style.AccentKey.ValueBuilder]? = nil,
        shapes: [Style.ShapeKey.ValueBuilderKeyPath: Style.ShapeKey.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            StyleOverrideModifier(
                numbers: numbers,
                fonts: fonts,
                icons: icons,
                surfaces: surfaces,
                compositions: compositions,
                accents: accents,
                shapes: shapes
            )
        )
    }

}


// MARK: - Modifier

private struct StyleOverrideModifier: ViewModifier {

    @Environment(\.style) private var style

    let numbers: [Style.NumberKey.ValueBuilderKeyPath: Style.NumberKey.ValueBuilder]?
    let fonts: [Style.FontKey.ValueBuilderKeyPath: Style.FontKey.ValueBuilder]?
    let icons: [Style.IconKey.ValueBuilderKeyPath: Style.IconKey.ValueBuilder]?
    let surfaces: [Style.SurfaceKey.ValueBuilderKeyPath: Style.SurfaceKey.ValueBuilder]?
    let compositions: [Style.CompositionKey.ValueBuilderKeyPath: Style.CompositionKey.ValueBuilder]?
    let accents: [Style.AccentKey.ValueBuilderKeyPath: Style.AccentKey.ValueBuilder]?
    let shapes: [Style.ShapeKey.ValueBuilderKeyPath: Style.ShapeKey.ValueBuilder]?

    func body(content: Content) -> some View {

        let definition = style.definition.replaced(
            numbers: numbers,
            fonts: fonts,
            icons: icons,
            surfaces: surfaces,
            compositions: compositions,
            accents: accents,
            shapes: shapes
        )

        content
            .style(update: definition)

    }

}


// MARK: - SnapStyle: replaced

extension Style {

    internal func replaced(
        numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]? = nil,
        fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]? = nil,
        icons: [IconKey.ValueBuilderKeyPath: IconKey.ValueBuilder]? = nil,
        surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]? = nil,
        compositions: [CompositionKey.ValueBuilderKeyPath: CompositionKey.ValueBuilder]? = nil,
        accents: [AccentKey.ValueBuilderKeyPath: AccentKey.ValueBuilder]? = nil,
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

        if let accents {
            style = style.appended(accents: accents)
        }

        if let shapes {
            style = style.appended(shapes: shapes)
        }

        return style
    }

}
