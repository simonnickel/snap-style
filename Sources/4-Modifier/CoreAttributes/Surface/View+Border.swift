//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleDefinitions
import SwiftUI

extension View {

    /// Applies the `Surface` as `.border()`
    ///
    /// Supports animated change.
    ///
    /// - Parameter border: The `Surface` to apply as border, `nil` will apply a clear border.
    /// - Parameter shape: The `Shape` to apply as border, `nil` will apply default shape.
    public func style(
        border keyPathSurface: Style.Attribute.Surface.ValueBuilderKeyPath?,
        shape keyPathShape: Style.Attribute.Shape.ValueBuilderKeyPath? = nil,
        width keyPathWidth: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
    ) -> some View {
        modifier(
            // TODO: Defaults correct?
            SurfaceBorderModifier(
                keyPathSurface: keyPathSurface,
                keyPathShape: keyPathShape ?? \.rectangle,
                keyPathWidth: keyPathWidth,
            )
        )
    }

}


// MARK: - Modifier

private struct SurfaceBorderModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPathSurface: Style.Attribute.Surface.ValueBuilderKeyPath?
    let keyPathShape: Style.Attribute.Shape.ValueBuilderKeyPath
    let keyPathWidth: Style.Attribute.Number.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        let borderWidth: Double? = if let keyPathWidth {
            style.number(for: keyPathWidth)
        } else { nil }
        content
            .overlay {
                StyleShapeView(shape: keyPathShape, border: keyPathSurface, width: keyPathWidth)
                    .padding((borderWidth ?? 0) / 2)
            }
    }

}


// MARK: - Preview

#Preview {

    StyleSurfaceBorderModifierExample()

}

package struct StyleSurfaceBorderModifierExample: View {
    
    struct Configuration {
        var shouldShowBorder: Bool = true
    }

    @State private var configuration: Configuration = .init()

    package init() {}

    package var body: some View {
        Text("Border Example")
            .padding()
            .style(border: configuration.shouldShowBorder ? \.accent : nil, shape: \.capsule, width: \.border)
        
        contentConfiguration
    }
    
    private var contentConfiguration: some View {
        VStack {
            Toggle(isOn: $configuration.shouldShowBorder.animation()) {
                Text("Show Border")
            }
        }
        .style(component: .infoCard)
    }
}
