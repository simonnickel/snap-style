//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI

public struct StyleLazyVStack<Content: View>: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: HorizontalAlignment
    private let width: FrameWidth
    private let content: () -> Content

    public init(
        _ spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: HorizontalAlignment = .leading,
        width: FrameWidth = .fill,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.width = width
        self.content = content
    }

    public var body: some View {
        LazyVStack(alignment: alignment, spacing: resolvedSpacing) {
            content()
        }
        .framed(width, alignment: Alignment(horizontal: alignment, vertical: .center))
        // LazyVStack takes its proposed width by default, so shrink to content when not filling.
        .fixedSize(horizontal: width == .fit, vertical: false)
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
        var width: FrameWidth = .fill
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
            configuration.spacing,
            width: configuration.width,
        ) {
            ForEach(0..<4) { index in
                Text("Item \(index)")
                    .style(component: .accentCard)
            }
        }
        .style(component: .contentCard)
    }

    private var contentConfiguration: some View {
        StyleVStack {
            StyleHStack {
                Text("Width")
                StylePicker(style: .segmented, selection: $configuration.width.animation()) {
                    ForEach(FrameWidth.allCases, id: \.self) { width in
                        Text(width.rawValue)
                            .tag(width)
                    }
                } label: {
                    Text("Select Width")
                }
            }

            StyleToggle(isOn: $configuration.shouldApplySpacing.animation()) {
                Text("Spacing between elements")
            }
        }
        .style(component: .infoCard)
    }
}
