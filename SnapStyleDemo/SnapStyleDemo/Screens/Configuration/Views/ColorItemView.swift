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
                    .style(foreground: \.accent)

                StyleStack(spacing: \.spacingElements) {
                    StyleStack(.horizontal, spacing: \.spacingElements) {
                        StyleIcon(\.indicatorUnread)
                            .style(element: .accessory)
                            .style(foreground: \.accentContrast)
                        StyleStack {
                            Text("Title")
                                .style(element: .title)
                        }
                        // TODO: Icon with circle background should be a component.
                        StyleIcon(\.favorite)
                            .style(element: .icon)
                            .style(padding: \.spacingElements)
                            .style(background: \.accentComplementary)
                            .style(shape: \.circle)
                    }

                    Text("Content Example")

                    StyleButton {
                        
                    } content: {
                        StyleStack(.horizontal, spacing: \.spacingElements) {
                            StyleIcon(\.indicatorUnread)
                                .style(element: .accessory)
                                .style(foreground: \.accentContrast)
                            Text("Select")
                                .stretch()
                            StyleIcon(\.indicatorMore)
                                .style(element: .accessory)
                                .style(foreground: \.accentComplementary)
                        }
                    }
                }
                .style(component: .accentCard)
                
                StyleStack(.horizontal, spacing: \.spacingElements) {
                    StyleStack() {
                        Circle()
                            .fill(accent.contrast)
                    }
                    .style(padding: \.paddingCard)
                    .style(background: \.accentGradientSoft)

                    StyleStack() {
                        Circle()
                            .fill(accent.complementary)
                    }
                    .style(padding: \.paddingCard)
                    .style(background: \.accentGradientStrong)
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
