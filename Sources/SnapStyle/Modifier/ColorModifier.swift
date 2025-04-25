//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    public func style(foreground keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(ColorForegroundModifier(keyPath: keyPath))
    }
    
    public func style(
        background keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath,
        ignoresSafeAreaEdges: Edge.Set = SnapStyle.CompositionKey.Value.LayeredShapeStyle.ignoresSafeAreaEdgesDefault
    ) -> some View {
        self
            .modifier(ColorBackgroundModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
    }
    
    /// Applies the given `ColorKey` as listRowBackground.
    /// - Parameter keyPath: The `ColorKey` to use.
    /// - Returns: A modified view.
    public func style(
        listRowBackground keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath
    ) -> some View {
        self
            .modifier(ColorListRowBackgroundColorModifier(keyPath: keyPath))
    }
    
    /// Applies the background layer of the given `CompositionKey` as listRowBackground.
    /// - Parameter keyPath: The `CompositionKey` to use.
    /// - Returns: A modified view.
    public func style(
        listRowBackground keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    ) -> some View {
        self
            .modifier(ColorListRowBackgroundCompositionModifier(keyPath: keyPath))
    }

}

// TODO: These Modifier are the perfect use case for a .if() modifier.

// MARK: - Modifier

internal struct ColorForegroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let color = style.color(for: keyPath, in: styleContext)
        {
            content
                .foregroundStyle(color)
        } else {
            content
        }
    }

}

internal struct ColorBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        if
            let color = style.color(for: keyPath, in: styleContext)
        {
            content
                .background(color, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}

internal struct ColorListRowBackgroundColorModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let color = style.color(for: keyPath, in: styleContext)
        {
            content
            // TODO: How to apply a generic shape style?
//                .listRowBackground(color)
        } else {
            content
        }
    }

}

// TODO: Should this be renamed?
internal struct ColorListRowBackgroundCompositionModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let background = style.composition(for: keyPath, in: styleContext)?.colorKey(for: .background),
            let color = style.color(for: background, in: styleContext)
        {
            content
            // TODO: How to apply a generic shape style?
//                .listRowBackground(color)
        } else {
            content
        }
    }

}
