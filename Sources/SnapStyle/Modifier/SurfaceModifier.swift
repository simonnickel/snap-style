//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    public func style(foreground keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(SurfaceForegroundModifier(keyPath: keyPath))
    }
    
    public func style(
        background keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath,
        ignoresSafeAreaEdges: Edge.Set = SnapStyle.CompositionKey.Value.LayeredShapeStyle.ignoresSafeAreaEdgesDefault
    ) -> some View {
        self
            .modifier(SurfaceBackgroundModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
    }
    
    /// Applies the given `SurfaceKey` as listRowBackground.
    /// - Parameter listRowBackground: The `SurfaceKey` to use.
    /// - Returns: A modified view.
    public func style(
        listRowBackground keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath
    ) -> some View {
        self
            .modifier(SurfaceListRowBackgroundSurfaceModifier(keyPath: keyPath))
    }
    
    /// Applies the background layer of the given `CompositionKey` as listRowBackground.
    /// - Parameter listRowBackground: The `CompositionKey` to use.
    /// - Returns: A modified view.
    public func style(
        listRowBackground keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    ) -> some View {
        self
            .modifier(SurfaceListRowBackgroundCompositionModifier(keyPath: keyPath))
    }

}

// TODO: These Modifier are the perfect use case for a .if() modifier.

// MARK: - Modifier

internal struct SurfaceForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let surface = style.surface(for: keyPath)
        {
            content
                .foregroundStyle(surface)
        } else {
            content
        }
    }

}

internal struct SurfaceBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        if
            let surface = style.surface(for: keyPath)
        {
            content
                .background(surface, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}

internal struct SurfaceListRowBackgroundSurfaceModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let surface = style.surface(for: keyPath)
        {
            content
                .listRowBackground(
                    Rectangle()
                        .fill(surface)
                )
        } else {
            content
        }
    }

}

internal struct SurfaceListRowBackgroundCompositionModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let background = style.composition(for: keyPath)?.surfaceKey(for: .background)
        {
            content
                .modifier(SurfaceListRowBackgroundSurfaceModifier(keyPath: background))
        } else {
            content
        }
    }

}
