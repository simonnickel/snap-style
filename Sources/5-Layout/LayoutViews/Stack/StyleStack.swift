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
    private let spacing: Style.Attribute.Number.ValueBuilderKeyPath?
    private let isStretching: Bool
    private let content: () -> Content

    public init(
        _ axis: Axis = .vertical,
        spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil,
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

    package static func spacing(for keyPath: Style.Attribute.Number.ValueBuilderKeyPath?, with style: Style.ContextWrapper) -> Style.Attribute.Number.Value.WrappedValue {
        guard let keyPath else { return 0 }

        return style.number(for: keyPath) ?? 0
    }

}


// MARK: - Preview

#Preview {
    StyleStackExample()
}

package struct StyleStackExample: View {
    
    @State var axisA: Axis = .horizontal
    @State var axisB: Axis = .horizontal
    @State var enabledStretching: Bool = true
    @State var enabledSpacing: Bool = true

    package init() {}
    
    package var body: some View {
        let spacing: Style.Attribute.Number.ValueBuilderKeyPath? = enabledSpacing ? \.spacingElements : nil
        StyleScreen {
            StyleStack(axisA, isStretching: enabledStretching) {
                Text("Axis A")
                    .style(component: .accentCard)
                StyleStack(axisB, isStretching: enabledStretching) {
                    Text("Axis B (1)")
                        .style(component: .accentCard)
                    Text("(2)")
                        .style(component: .accentCard)
                }
                .style(component: .accentCard)
            }
            .style(component: .contentCard)
            .style(spacing: spacing)
            
            // TODO: This should be an inline list
            VStack {
                
                HStack {
                    Text("Axis A")
                    StylePicker(style: .segmented, selection: $axisA.animation()) {
                        ForEach(Axis.allCases, id: \.self) { axis in
                            Text(axis.description)
                                .tag(axis)
                        }
                    } label: {
                        Text("Select Axis A")
                    }
                }
                HStack {
                    Text("Axis B")
                    StylePicker(style: .segmented, selection: $axisB.animation()) {
                        ForEach(Axis.allCases, id: \.self) { axis in
                            Text(axis.description)
                                .tag(axis)
                        }
                    } label: {
                        Text("Select Axis B")
                    }
                }

                StyleToggle(isOn: $enabledStretching.animation()) {
                    Text("Stretch Container")
                }
                StyleToggle(isOn: $enabledSpacing.animation()) {
                    Text("Spacing between elements")
                }
            }
            .padding(.top, 20)
        }
    }
}
