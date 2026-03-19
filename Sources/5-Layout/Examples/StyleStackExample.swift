//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

package struct StyleStackExample: View {
    
    @State var axis: Axis = .vertical
    @State var stretching: Bool = true
    @State var spacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil

    package init() {}
    
    package var body: some View {
        StyleStack(axis, isStretching: stretching) {
            Text("Test Row 1")
                .background(.green)
            StyleStack(.horizontal, isStretching: stretching) {
                Text("Test Row 2")
                    .background(.mint)
                Text("Test Row 3")
                    .background(.teal)
            }
//            .style(spacing: nil)
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
}


// MARK: - Preview

#Preview {
    StyleStackExample()
}
