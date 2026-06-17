//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Stack {

    /// Lazy vertical stack with type-safe horizontal alignment.
    public static func VLazy(
        alignment: HorizontalAlignment = .leading,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content,
    ) -> some View {
        _LazyVStack(
            alignment: alignment,
            spacing: spacing,
            fillsWidth: fillsWidth,
            content: content,
        )
    }

}


// MARK: - Implementation

internal struct _LazyVStack<Content: View>: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let alignment: HorizontalAlignment
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let fillsWidth: Bool
    private let content: () -> Content

    init(
        alignment: HorizontalAlignment,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath?,
        fillsWidth: Bool,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.fillsWidth = fillsWidth
        self.content = content
    }

    var body: some View {
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
    StackVLazyExample()
}

package struct StackVLazyExample: View {

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
        Stack.VLazy(
            spacing: configuration.spacing,
            fillsWidth: configuration.shouldFillWidth,
        ) {
            ForEach(0..<4) { index in
                Text("Item \(index)")
                    .style(component: .accentCard)
            }
        }
        .style(component: .contentCard)
    }

    private var contentConfiguration: some View {
        Stack {
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
