//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

/// A container that stacks its content on the defined Axis.
/// Switching the Axis can be animated.
public struct StyleStack<Content>: View where Content: View {

    @Environment(\.style) private var style
    @Environment(\.styleStackSpacing) private var styleStackSpacing

    private let axis: Axis
    private let alignmentV: VerticalAlignment
    private let alignmentH: HorizontalAlignment
    private let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath?
    private let isStretching: Bool
    private let content: () -> Content

    public init(
        _ axis: Axis = .vertical,
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath? = nil,
        alignmentV: VerticalAlignment = .center,
        alignmentH: HorizontalAlignment = .leading,
        isStretching: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.alignmentV = alignmentV
        self.alignmentH = alignmentH
        self.spacing = spacing
        self.isStretching = isStretching
        self.content = content
    }

    public var body: some View {
        contentStack
            .frame(maxWidth: isStretching ? .infinity : nil, alignment: Alignment(horizontal: alignmentH, vertical: alignmentV))
    }

    @ViewBuilder
    private var contentStack: some View {
        let spacingKeyPath = spacing ?? styleStackSpacing
        let spacing = CGFloat(Self.spacing(for: spacingKeyPath, with: style))
        let layout = axis == .vertical
            ? AnyLayout(VStackLayout(alignment: alignmentH, spacing: spacing))
            : AnyLayout(HStackLayout(alignment: alignmentV, spacing: spacing))

        layout {
            content()
        }
    }

    package static func spacing(for keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath?, with style: SnapStyle.ContextWrapper) -> SnapStyle.NumberKey.Value.WrappedValue {
        guard let keyPath else { return 0 }

        return switch style.value(for: keyPath) {
            case .value(let value): value
            case .none: 0
        }
    }

}


// MARK: - Preview

#Preview {
    @Previewable @State var axis: Axis = .vertical
    @Previewable @State var stretching: Bool = true
    @Previewable @State var spacing: SnapStyle.NumberKey.ValueBuilderKeyPath? = nil

    StyleStack(axis, isStretching: stretching) {
        Text("Test Row 1")
            .background(.green)
        StyleStack(.horizontal, isStretching: stretching) {
            Text("Test Row 2")
                .background(.mint)
            Text("Test Row 3")
                .background(.teal)
        }
    }
    .background(.yellow)
    .style(spacing: spacing)

    HStack {
        StyleButton {
            withAnimation {
                axis = axis == .horizontal ? .vertical : .horizontal
            }
        } content: {
            Text("Toggle Axis")
        }

        StyleButton {
            withAnimation {
                stretching.toggle()
            }
        } content: {
            Text("Toggle Stretching")
        }

        StyleButton {
            withAnimation {
                spacing = spacing == nil ? \.spacingElements : nil
            }
        } content: {
            Text("Toggle Spacing")
        }
    }
    .padding(.top, 20)
}
