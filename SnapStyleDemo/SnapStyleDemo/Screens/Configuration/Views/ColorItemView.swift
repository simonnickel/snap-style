//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ColorItemView: View {

    let selected: Bool

    var body: some View {
        StyleVStack {
            StyleVStack(\.spacingGroups) {
                
                Text("Select")
                    .style(element: .title)
                    .style(foreground: \.accent)

                StyleVStack(\.spacingElements) {
                    StyleHStack(\.spacingElements) {
                        StyleIcon(\.indicatorUnread)
                            .style(element: .accessory)
                            .style(foreground: \.accentContrast)
                        StyleVStack {
                            Text("Title")
                                .style(element: .title)
                        }
                        // TODO feature: Icon with circle background should be a component.
                        StyleIcon(\.favorite)
                            .style(element: .icon)
                            .style(padding: \.spacingElements)
                            .style(background: \.accentComplementary)
                            .style(shape: \.circle)
                    }

                    Text("Content Example")

                    StyleButton {
                        
                    } content: {
                        StyleHStack(\.spacingElements) {
                            StyleIcon(\.indicatorUnread)
                                .style(element: .accessory)
                                .style(foreground: \.accentContrast)
                            Text("Select")
                                .framed()
                            StyleIcon(\.indicatorMore)
                                .style(element: .accessory)
                                .style(foreground: \.accentComplementary)
                        }
                    }
                }
                .style(component: .accentCard)
                
                StyleHStack(\.spacingElements, alignment: .center) {
                    StyleShapeView(shape: \.circle, surface: \.accentContrast)
                        .style(padding: \.containerCard)
                        .style(background: \.accentGradientSoft)

                    StyleShapeView(shape: \.circle, surface: \.accentComplementary)
                        .style(padding: \.containerCard)
                        .style(background: \.accentGradientStrong)
                }
                .frame(minHeight: 100) // Required for Preview only
            }
        }
        .style(component: .contentCard)
        .border(.primary, width: selected ? 5 : 0)
    }

}


// MARK: - Preview

#Preview {
    VStack {
        ColorItemView(selected: false)
            .frame(width: 200, height: 200)
        ColorItemView(selected: true)
            .frame(width: 200, height: 200)
    }
}
