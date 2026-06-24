//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI


// MARK: - Preview

#Preview {
    StyleStackExample()
}

package struct StyleStackExample: View {

    struct Configuration {
        var axisA: Axis = .horizontal
        var axisB: Axis = .horizontal
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
            stackExample
            stackConfiguration
            vStackExample
            hStackExample
            vhStackConfiguration
        }
    }

    // MARK: StyleStack

    private var stackExample: some View {
        StyleVStack {
            Text("StyleStack")
                .style(element: .title)
            
            StyleStack(axis: configuration.axisA, spacing: configuration.spacing) {
                Text("Axis A")
                    .style(component: .accentCard)
                StyleStack(axis: configuration.axisB, spacing: configuration.spacing) {
                    Text("Axis B (1)")
                        .style(component: .accentCard)
                    Text("(2)")
                        .style(component: .accentCard)
                }
                .style(component: .accentCard)
            }
        }
        .style(component: .contentCard)
    }

    // TODO: This could be an inline list
    private var stackConfiguration: some View {
        StyleVStack {
            StyleHStack {
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

            StyleHStack {
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

            StyleToggle(isOn: $configuration.shouldApplySpacing.animation()) {
                Text("Spacing between elements")
            }
        }
        .style(component: .infoCard)
    }

    // MARK: StyleVStack / StyleHStack

    @ViewBuilder
    private var vStackExample: some View {
        StyleVStack {
            Text("StyleVStack")
                .style(element: .title)
            
            StyleVStack(width: configuration.width) {
                Text("A")
                    .style(component: .accentCard)
                Text("B")
                    .style(component: .accentCard)
            }
            .style(component: .accentCard)
        }
        .style(component: .contentCard)
    }
    

    @ViewBuilder
    private var hStackExample: some View {
        StyleVStack {

            Text("StyleHStack")
                .style(element: .title)
            
            StyleHStack(width: configuration.width) {
                Text("A")
                    .style(component: .accentCard)
                Text("B")
                    .style(component: .accentCard)
            }
            .style(component: .accentCard)
        }
        .style(component: .contentCard)
    }

    private var vhStackConfiguration: some View {
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
        }
        .style(component: .infoCard)
    }
}
