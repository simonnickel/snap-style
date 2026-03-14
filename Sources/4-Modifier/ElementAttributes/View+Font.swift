//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    public func style(font keyPath: Style.Attribute.Font.ValueBuilderKeyPath) -> some View {
        modifier(FontModifier(keyPath: keyPath))
    }
    
    /// Convenience shortcut to define a `Font` for an element via environment.
    public func styleDefine(
        font key: Style.Attribute.Font.ValueBuilderKeyPath?,
        for element: Style.Element.ElementType,
        shouldClear: Bool = false,
    ) -> some View {
        style(
            define: Style.Attribute.Font.self,
            key: key,
            for: element,
            shouldClear: shouldClear,
        )
    }

}


// MARK: - Modifier

package struct FontModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Font.ValueBuilderKeyPath?

    package func body(content: Content) -> some View {
        let properties: Style.Attribute.Font.Value.Properties? = if let keyPath {
            style.font(for: keyPath)
        } else { nil }
        content
            .modifier(ScaledFont(properties: properties))
    }

}

private struct ScaledFont: ViewModifier {
    
    @Environment(\.style) private var style
    
    private let properties: Style.Attribute.Font.Value.Properties?
    private let scaled: ScaledMetric<Double>

    init(properties: Style.Attribute.Font.Value.Properties?) {
        self.properties = properties
        self.scaled = ScaledMetric(wrappedValue: Double(properties?.size ?? .zero), relativeTo: properties?.textStyle ?? .body)
    }
    
    func body(content: Content) -> some View {
        let size = scaled.wrappedValue * style.context.scaleFactor
        let font = properties?.font(size: size)

        return content
            .font(font)
            .fontDesign(properties?.design ?? style.context.fontDesign)
            .fontWidth(properties?.width ?? style.context.fontWidth)
    }
}


// MARK: - Preview

#if DEBUG
extension Style.Component {
    
    static let previewFont: Self = .init(
        "previewFont",
        container: .contentCard,
        fonts: { element in
            switch element {
            case .icon: \.listIcon
                default: nil
            }
        },
    )
                                         
}
#endif

#Preview {
    
    @Previewable @State var override: Bool = true

    VStack(alignment: .leading, spacing: 15) {
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
            Text("Font from Component")
                .style(element: .label)
        }
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
                .styleDefine(font: override ? \.screenTitle : nil, for: .icon)
            Toggle(isOn: $override.animation()) {
                Text("Define override")
                    .style(element: .label)
            }
        }
    }
    .style(component: .previewFont)

}
