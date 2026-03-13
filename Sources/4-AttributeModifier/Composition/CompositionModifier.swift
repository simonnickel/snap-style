//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {
    
    /// Applies the given `Layer` of the `Composition`.
    ///
    /// Supports animated change.
    ///
    /// - Parameters:
    ///   - keyPath: The `Composition` to apply.
    ///   - layers: The `Layer`s that should be applied
    ///   - ignoreSafeAreaEdges: Controls the safe area behaviour of the background.
    public func style(
        composition keyPath: Style.Attribute.Composition.ValueBuilderKeyPath,
        layers: [Style.Attribute.Composition.Layer] = Style.Attribute.Composition.Layer.allCases,
        ignoreSafeAreaEdges: Edge.Set = []
    ) -> some View {
        modifier(CompositionModifier(keyPath: keyPath, layers: layers, ignoresSafeAreaEdges: ignoreSafeAreaEdges))
    }

}


// MARK: - Composition for Element

extension View {

    public func styleApplyComposition(
        for element: Style.Element.ElementType,
        layers: [Style.Attribute.Composition.Layer] = Style.Attribute.Composition.Layer.allCases,
        ignoreSafeAreaEdges: Edge.Set = []
    ) -> some View {
        let keyPath = Style.Attribute.Composition.keyPath(for: element)
        return modifier(CompositionFromEnvironmentModifier(keyPath: keyPath, layers: layers, ignoresSafeAreaEdges: ignoreSafeAreaEdges))
    }

    @ViewBuilder
    public func styleSetup(composition key: Style.Attribute.Composition.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        if let key {
            let keyPath = Style.Attribute.Composition.keyPath(for: element)
            environment(keyPath, key)
        } else {
            self
        }
    }

    @ViewBuilder
    package func setupComposition(for component: Style.Component) -> some View {
        self
            .styleSetup(composition: component.compositions?(.any), for: .any)
            .styleSetup(composition: component.compositions?(.title), for: .title)
            .styleSetup(composition: component.compositions?(.label), for: .label)
            .styleSetup(composition: component.compositions?(.icon), for: .icon)
            .styleSetup(composition: component.compositions?(.value), for: .value)
            .styleSetup(composition: component.compositions?(.accessory), for: .accessory)
            .styleSetup(composition: component.compositions?(.separator), for: .separator)
            .styleSetup(composition: component.compositions?(.footnote), for: .footnote)
    }

}


// MARK: - Modifier

private struct CompositionFromEnvironmentModifier: ViewModifier {

    @Environment(\.self) private var environment
    @Environment(\.style) private var style

    let keyPath: KeyPath<EnvironmentValues, Style.Attribute.Composition.ValueBuilderKeyPath>
    let layers: [Style.Attribute.Composition.Layer]
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let key = environment[keyPath: keyPath]
        content
            .modifier(CompositionModifier(keyPath: key, layers: layers, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
    }

}

private struct CompositionModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Composition.ValueBuilderKeyPath
    let layers: [Style.Attribute.Composition.Layer]
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        content
            .modifier(CompositionBackgroundOverlayModifier(keyPath: layers.contains(.backgroundOverlay) ? keyPath : nil, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            .modifier(CompositionBackgroundModifier(keyPath: layers.contains(.background) ? keyPath : nil, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            .modifier(CompositionForegroundModifier(keyPath: layers.contains(.foreground) ? keyPath : nil))
    }

}

private struct CompositionForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Composition.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        let surfaceKey: Style.Attribute.Surface.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .foreground, for: keyPath) } else { nil }
        content
            .style(foreground: surfaceKey)
    }

}

private struct CompositionBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Composition.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let surfaceKey: Style.Attribute.Surface.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .background, for: keyPath) } else { nil }
        content
            .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}

private struct CompositionBackgroundOverlayModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Composition.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let surfaceKey: Style.Attribute.Surface.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .backgroundOverlay, for: keyPath) } else { nil }
        content
            .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}


// MARK: - Preview

#Preview {

    @Previewable @State var isAccent: Bool = false

    VStack() {
        Text("Content")
    }
    .padding()
    .style(composition: isAccent ? \.accentContainer : \.contentContainer)
    .border(.yellow)

    Button {
        withAnimation {
            isAccent.toggle()
        }
    } label: {
        Text("Toggle Accent")
    }

}
