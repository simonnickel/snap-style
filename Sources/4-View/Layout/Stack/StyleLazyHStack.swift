//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLazyHStack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: VerticalAlignment
    private let fillsWidth: Bool
    private let content: () -> Content

    public init(
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.fillsWidth = fillsWidth
        self.content = content
    }

    public var body: some View {
        LazyHStack(alignment: alignment, spacing: resolvedSpacing) {
            content()
        }
        .frame(maxWidth: fillsWidth ? .infinity : nil, alignment: Alignment(horizontal: .leading, vertical: alignment))
    }

    private var resolvedSpacing: CGFloat {
        if let key = spacing ?? styleSpacing, let value = style.number(for: key) {
            CGFloat(value)
        } else { 0 }
    }

}


// MARK: - Preview

#Preview {
    StyleLazyHStackExample()
}

package struct StyleLazyHStackExample: View {

    struct Configuration {
        var shouldFillWidth: Bool = true
        var shouldApplySpacing: Bool = true

        var spacing: Style.Attribute.Number.ValueBuilderKeyPath {
            shouldApplySpacing ? \.spacingElements : \.zero
        }
    }

    @State private var configuration: Configuration = .init()

    package init() {}

    package var body: some View {
        StyleScreen {
            contentExample
            contentConfiguration
        }
    }

    private var contentExample: some View {
        StyleLazyHStack(
            spacing: configuration.spacing,
            fillsWidth: configuration.shouldFillWidth
        ) {
            ForEach(0..<4) { index in
                Text("Item \(index)")
                    .style(component: .accentCard)
            }
        }
        .style(component: .contentCard)
    }

    private var contentConfiguration: some View {
        StyleStack {
            StyleToggle(isOn: $configuration.shouldFillWidth.animation()) {
                Text("Fill Width")
            }

            StyleToggle(isOn: $configuration.shouldApplySpacing.animation()) {
                Text("Spacing between elements")
            }
        }
        .style(component: .infoCard)
    }
}
