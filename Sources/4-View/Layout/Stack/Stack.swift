//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

/// A container that stacks its content on the defined Axis.
/// Switching the Axis can be animated.
public struct Stack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let axis: Axis
    private let alignment: Alignment
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let fillsWidth: Bool
    private let content: () -> Content

    public init(
        axis: Axis,
        alignment: Alignment = .leading,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.fillsWidth = fillsWidth
        self.content = content
    }

    public var body: some View {
        resolvedLayout {
            content()
        }
        .frame(maxWidth: fillsWidth ? .infinity : nil, alignment: alignment)
    }

    private var resolvedLayout: AnyLayout {
        return axis == .vertical
        ? AnyLayout(VStackLayout(alignment: alignment.horizontal, spacing: resolvedSpacing))
        : AnyLayout(HStackLayout(alignment: alignment.vertical, spacing: resolvedSpacing))
    }

    private var resolvedSpacing: CGFloat {
        if let key = spacing ?? styleSpacing, let value = style.number(for: key) {
            CGFloat(value)
        } else { 0 }
    }

}


// MARK: - StackV

public struct StackV<Content>: View where Content: View {

    private let alignment: HorizontalAlignment
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let fillsWidth: Bool
    private let content: () -> Content

    public init(
        alignment: HorizontalAlignment = .leading,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.fillsWidth = fillsWidth
        self.content = content
    }

    public var body: some View {
        Stack(
            axis: .vertical,
            alignment: Alignment(horizontal: alignment, vertical: .center),
            spacing: spacing,
            fillsWidth: fillsWidth,
            content: content,
        )
    }

}


// MARK: - StackH

public struct StackH<Content>: View where Content: View {

    private let alignment: VerticalAlignment
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let fillsWidth: Bool
    private let content: () -> Content

    public init(
        alignment: VerticalAlignment = .center,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        fillsWidth: Bool = true,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.fillsWidth = fillsWidth
        self.content = content
    }

    public var body: some View {
        Stack(
            axis: .horizontal,
            alignment: Alignment(horizontal: .leading, vertical: alignment),
            spacing: spacing,
            fillsWidth: fillsWidth,
            content: content,
        )
    }

}


// MARK: - Preview

#Preview {
    StackExample()
}

package struct StackExample: View {

    struct Configuration {
        var axisA: Axis = .horizontal
        var axisB: Axis = .horizontal
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
        Stack(
            axis: configuration.axisA,
            spacing: configuration.spacing,
            fillsWidth: configuration.shouldFillWidth,
        ) {
            Text("Axis A")
                .style(component: .accentCard)
            Stack(
                axis: configuration.axisB,
                spacing: configuration.spacing,
                fillsWidth: configuration.shouldFillWidth,
            ) {
                Text("Axis B (1)")
                    .style(component: .accentCard)
                Text("(2)")
                    .style(component: .accentCard)
            }
            .style(component: .accentCard)
        }
        .style(component: .contentCard)
    }

    // TODO: This could be an inline list
    private var contentConfiguration: some View {
        StackV {
            StackH {
                Text("Axis A")
                StylePicker(style: .segmented, selection: $configuration.axisA.animation()) {
                    ForEach(Axis.allCases, id: \.self) { axis in
                        Text(axis.description)
                            .tag(axis)
                    }
                } label: {
                    Text("Select Axis A")
                }
            }

            StackH {
                Text("Axis B")
                StylePicker(style: .segmented, selection: $configuration.axisB.animation()) {
                    ForEach(Axis.allCases, id: \.self) { axis in
                        Text(axis.description)
                            .tag(axis)
                    }
                } label: {
                    Text("Select Axis B")
                }
            }

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
