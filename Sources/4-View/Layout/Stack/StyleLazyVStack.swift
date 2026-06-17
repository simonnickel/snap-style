//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLazyVStack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: HorizontalAlignment
    private let fillsWidth: Bool
    private let content: () -> Content

    public init(
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.fillsWidth = fillsWidth
        self.content = content
    }

    public var body: some View {
        LazyVStack(alignment: alignment, spacing: resolvedSpacing) {
            content()
        }
        .frame(maxWidth: fillsWidth ? .infinity : nil, alignment: Alignment(horizontal: alignment, vertical: .center))
        // LazyVStack takes its proposed width by default, so shrink to content when not filling.
        .fixedSize(horizontal: !fillsWidth, vertical: false)
    }

    private var resolvedSpacing: CGFloat {
        if let key = spacing ?? styleSpacing, let value = style.number(for: key) {
            CGFloat(value)
        } else { 0 }
    }

}


// MARK: - Preview

#Preview {
    StyleLazyVStackExample()
}

package struct StyleLazyVStackExample: View {

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
        StyleLazyVStack(
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
