//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI

public struct StyleLazyHStack<Content: View>: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: VerticalAlignment
    private let width: FrameWidth
    private let content: () -> Content

    public init(
        _ spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: VerticalAlignment = .center,
        width: FrameWidth = .fill,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.spacing = spacing
        self.alignment = alignment
        self.width = width
        self.content = content
    }

    public var body: some View {
        LazyHStack(alignment: alignment, spacing: resolvedSpacing) {
            content()
        }
        .framed(width, alignment: Alignment(horizontal: .leading, vertical: alignment))
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
        StyleLazyHStack(
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
