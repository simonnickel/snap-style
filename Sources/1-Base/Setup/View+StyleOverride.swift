//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func styleOverride(
        numbers: [Style.Attribute.Number.ValueBuilderKeyPath: Style.Attribute.Number.ValueBuilder]? = nil,
        paddings: [Style.Attribute.Padding.ValueBuilderKeyPath: Style.Attribute.Padding.ValueBuilder]? = nil,
        fonts: [Style.Attribute.Font.ValueBuilderKeyPath: Style.Attribute.Font.ValueBuilder]? = nil,
        icons: [Style.Attribute.Icon.ValueBuilderKeyPath: Style.Attribute.Icon.ValueBuilder]? = nil,
        surfaces: [Style.Attribute.Surface.ValueBuilderKeyPath: Style.Attribute.Surface.ValueBuilder]? = nil,
        compositions: [Style.Attribute.Composition.ValueBuilderKeyPath: Style.Attribute.Composition.ValueBuilder]? = nil,
        accents: [Style.Attribute.Accent.ValueBuilderKeyPath: Style.Attribute.Accent.ValueBuilder]? = nil,
        shapes: [Style.Attribute.Shape.ValueBuilderKeyPath: Style.Attribute.Shape.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            Style.OverrideModifier(
                numbers: numbers,
                paddings: paddings,
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
        
        let numbers: [Attribute.Number.ValueBuilderKeyPath: Attribute.Number.ValueBuilder]?
        let paddings: [Attribute.Padding.ValueBuilderKeyPath: Attribute.Padding.ValueBuilder]?
        let fonts: [Attribute.Font.ValueBuilderKeyPath: Attribute.Font.ValueBuilder]?
        let icons: [Attribute.Icon.ValueBuilderKeyPath: Attribute.Icon.ValueBuilder]?
        let surfaces: [Attribute.Surface.ValueBuilderKeyPath: Attribute.Surface.ValueBuilder]?
        let compositions: [Attribute.Composition.ValueBuilderKeyPath: Attribute.Composition.ValueBuilder]?
        let accents: [Attribute.Accent.ValueBuilderKeyPath: Attribute.Accent.ValueBuilder]?
        let shapes: [Attribute.Shape.ValueBuilderKeyPath: Attribute.Shape.ValueBuilder]?
        
        func body(content: Content) -> some View {
            
            let definition = style.definition.replaced(
                numbers: numbers,
                paddings: paddings,
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
        numbers: [Attribute.Number.ValueBuilderKeyPath: Attribute.Number.ValueBuilder]? = nil,
        paddings: [Attribute.Padding.ValueBuilderKeyPath: Attribute.Padding.ValueBuilder]? = nil,
        fonts: [Attribute.Font.ValueBuilderKeyPath: Attribute.Font.ValueBuilder]? = nil,
        icons: [Attribute.Icon.ValueBuilderKeyPath: Attribute.Icon.ValueBuilder]? = nil,
        surfaces: [Attribute.Surface.ValueBuilderKeyPath: Attribute.Surface.ValueBuilder]? = nil,
        compositions: [Attribute.Composition.ValueBuilderKeyPath: Attribute.Composition.ValueBuilder]? = nil,
        accents: [Attribute.Accent.ValueBuilderKeyPath: Attribute.Accent.ValueBuilder]? = nil,
        shapes: [Attribute.Shape.ValueBuilderKeyPath: Attribute.Shape.ValueBuilder]? = nil
    ) -> Self {
        var style = self

        if let numbers {
            style = style.appended(numbers: numbers)
        }
        
        if let paddings {
            style = style.appended(paddings: paddings)
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
