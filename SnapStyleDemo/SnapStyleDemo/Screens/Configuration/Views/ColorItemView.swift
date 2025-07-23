//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ColorItemView: View {

    let accent: SnapStyle.Accent
    let selected: Bool

    var body: some View {
        StyleStack {
            StyleStack(spacing: \.spacingGroups) {
                
                Text("Select")
                    .style(element: .title)
                
                StyleStack(spacing: \.spacingElements) {
                    StyleStack(.horizontal, spacing: \.spacingElements) {
                        // TODO: Icon with circle backgound should be a component.
                        StyleIcon(\.favorite)
                            .style(element: .icon)
                            .style(padding: \.spacingElements)
                            .style(background: \.accentComplementary)
                            .style(shape: \.circle)
                        StyleStack {
                            Text("Title")
                                .style(element: .title)
                        }
                    }
                    StyleStack(.horizontal, spacing: \.spacingElements) {
                        Text("Content Example")
                        StyleIcon(selected ? \.selectionOn : \.selectionOff)
                            .style(element: .accessory)
                            .style(foreground: \.accentContrast)
                    }
                }
                .style(component: .accentCard)
                
                StyleStack(.horizontal, spacing: \.spacingElements) {
                    StyleStack() {
                        Circle()
                            .fill(accent.complementary)
                    }
                    .style(padding: \.paddingCard)
                    .style(background: \.accentGradientStrong)

                    StyleStack() {
                        Circle()
                            .fill(accent.contrast)
                    }
                    .style(padding: \.paddingCard)
                    .style(background: \.accentGradientSoft)
                }
            }
        }
        .style(component: .contentCard)
    }
}


// MARK: - Preview

#Preview {
    VStack {
        ColorItemView(accent: .fallback, selected: false)
            .frame(width: 200, height: 200)
        ColorItemView(accent: .fallback, selected: true)
            .frame(width: 200, height: 200)
    }
}
