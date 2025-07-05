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
            StyleStack(spacing: \.spacingGroups, alignmentH: .center) {
                Text("Select")
                    .style(element: .title)
                    .style(foreground: \.onAccent)
                    .padding(.top, 8)
                HStack {
                    Circle()
                        .fill(accent.complementary)
                    Circle()
                        .fill(accent.contrast)
                }
            }
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: 5)
                .stroke(selected ? Color.primary : .clear, lineWidth: 2)
                .fill(Gradient(colors: [accent.base, accent.complementary]))
                .padding(2)
        }
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
