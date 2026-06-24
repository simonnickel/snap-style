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


// MARK: - Preview

#Preview {
    StyleStackExample()
}
