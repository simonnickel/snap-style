//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func styleOverride(
        numbers: [Style.Attributes.Number.ValueBuilderKeyPath: Style.Attributes.Number.ValueBuilder]? = nil,
        fonts: [Style.Attributes.Font.ValueBuilderKeyPath: Style.Attributes.Font.ValueBuilder]? = nil,
        icons: [Style.Attributes.Icon.ValueBuilderKeyPath: Style.Attributes.Icon.ValueBuilder]? = nil,
        surfaces: [Style.Attributes.Surface.ValueBuilderKeyPath: Style.Attributes.Surface.ValueBuilder]? = nil,
        compositions: [Style.Attributes.Composition.ValueBuilderKeyPath: Style.Attributes.Composition.ValueBuilder]? = nil,
        accents: [Style.Attributes.Accent.ValueBuilderKeyPath: Style.Attributes.Accent.ValueBuilder]? = nil,
        shapes: [Style.Attributes.Shape.ValueBuilderKeyPath: Style.Attributes.Shape.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            Style.OverrideModifier(
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

extension Style {
    
    struct OverrideModifier: ViewModifier {
        
        @Environment(\.style) private var style
        
        let numbers: [Attributes.Number.ValueBuilderKeyPath: Attributes.Number.ValueBuilder]?
        let fonts: [Attributes.Font.ValueBuilderKeyPath: Attributes.Font.ValueBuilder]?
        let icons: [Attributes.Icon.ValueBuilderKeyPath: Attributes.Icon.ValueBuilder]?
        let surfaces: [Attributes.Surface.ValueBuilderKeyPath: Attributes.Surface.ValueBuilder]?
        let compositions: [Attributes.Composition.ValueBuilderKeyPath: Attributes.Composition.ValueBuilder]?
        let accents: [Attributes.Accent.ValueBuilderKeyPath: Attributes.Accent.ValueBuilder]?
        let shapes: [Attributes.Shape.ValueBuilderKeyPath: Attributes.Shape.ValueBuilder]?
        
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
    
}


// MARK: - SnapStyle: replaced

extension Style {

    private func replaced(
        numbers: [Attributes.Number.ValueBuilderKeyPath: Attributes.Number.ValueBuilder]? = nil,
        fonts: [Attributes.Font.ValueBuilderKeyPath: Attributes.Font.ValueBuilder]? = nil,
        icons: [Attributes.Icon.ValueBuilderKeyPath: Attributes.Icon.ValueBuilder]? = nil,
        surfaces: [Attributes.Surface.ValueBuilderKeyPath: Attributes.Surface.ValueBuilder]? = nil,
        compositions: [Attributes.Composition.ValueBuilderKeyPath: Attributes.Composition.ValueBuilder]? = nil,
        accents: [Attributes.Accent.ValueBuilderKeyPath: Attributes.Accent.ValueBuilder]? = nil,
        shapes: [Attributes.Shape.ValueBuilderKeyPath: Attributes.Shape.ValueBuilder]? = nil
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
