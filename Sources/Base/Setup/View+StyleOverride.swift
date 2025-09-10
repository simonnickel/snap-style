//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func styleOverride(
        numbers: [Style.Keys.Number.ValueBuilderKeyPath: Style.Keys.Number.ValueBuilder]? = nil,
        fonts: [Style.Keys.Font.ValueBuilderKeyPath: Style.Keys.Font.ValueBuilder]? = nil,
        icons: [Style.Keys.Icon.ValueBuilderKeyPath: Style.Keys.Icon.ValueBuilder]? = nil,
        surfaces: [Style.Keys.Surface.ValueBuilderKeyPath: Style.Keys.Surface.ValueBuilder]? = nil,
        compositions: [Style.Keys.Composition.ValueBuilderKeyPath: Style.Keys.Composition.ValueBuilder]? = nil,
        accents: [Style.Keys.Accent.ValueBuilderKeyPath: Style.Keys.Accent.ValueBuilder]? = nil,
        shapes: [Style.Keys.Shape.ValueBuilderKeyPath: Style.Keys.Shape.ValueBuilder]? = nil
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
        
        let numbers: [Keys.Number.ValueBuilderKeyPath: Keys.Number.ValueBuilder]?
        let fonts: [Keys.Font.ValueBuilderKeyPath: Keys.Font.ValueBuilder]?
        let icons: [Keys.Icon.ValueBuilderKeyPath: Keys.Icon.ValueBuilder]?
        let surfaces: [Keys.Surface.ValueBuilderKeyPath: Keys.Surface.ValueBuilder]?
        let compositions: [Keys.Composition.ValueBuilderKeyPath: Keys.Composition.ValueBuilder]?
        let accents: [Keys.Accent.ValueBuilderKeyPath: Keys.Accent.ValueBuilder]?
        let shapes: [Keys.Shape.ValueBuilderKeyPath: Keys.Shape.ValueBuilder]?
        
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

    internal func replaced(
        numbers: [Keys.Number.ValueBuilderKeyPath: Keys.Number.ValueBuilder]? = nil,
        fonts: [Keys.Font.ValueBuilderKeyPath: Keys.Font.ValueBuilder]? = nil,
        icons: [Keys.Icon.ValueBuilderKeyPath: Keys.Icon.ValueBuilder]? = nil,
        surfaces: [Keys.Surface.ValueBuilderKeyPath: Keys.Surface.ValueBuilder]? = nil,
        compositions: [Keys.Composition.ValueBuilderKeyPath: Keys.Composition.ValueBuilder]? = nil,
        accents: [Keys.Accent.ValueBuilderKeyPath: Keys.Accent.ValueBuilder]? = nil,
        shapes: [Keys.Shape.ValueBuilderKeyPath: Keys.Shape.ValueBuilder]? = nil
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
