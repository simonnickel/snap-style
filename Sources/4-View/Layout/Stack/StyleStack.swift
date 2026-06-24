//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI

/// A layout container that stacks its content on the defined Axis.
/// Use `StyleVStack` / `StyleHStack` for the common use cases.
///
/// Using `StyleStack` directly is useful for:
/// - Animated switching of the Axis.
/// - Custom alignment guides on children propagate to its parent.
public struct StyleStack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleSpacing) private var styleSpacing

    private let axis: Axis
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let alignment: Alignment
    private let content: () -> Content

    public init(
        axis: Axis,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
        alignment: Alignment = .leading,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    public var body: some View {
        resolvedLayout {
            content()
        }
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


// MARK: - StyleVStack

public struct StyleVStack<Content>: View where Content: View {

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
        StyleStack(
            axis: .vertical,
            spacing: spacing,
            alignment: Alignment(horizontal: alignment, vertical: .center),
            content: content,
        )
        .framed(width, alignment: Alignment(horizontal: alignment, vertical: .center))
    }

}


// MARK: - StyleHStack

public struct StyleHStack<Content>: View where Content: View {

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
        StyleStack(
            axis: .horizontal,
            spacing: spacing,
            alignment: Alignment(horizontal: .leading, vertical: alignment),
            content: content,
        )
        .framed(width, alignment: Alignment(horizontal: .leading, vertical: alignment))
    }

}


// MARK: - Preview

#Preview {
    StyleStackExample()
}
