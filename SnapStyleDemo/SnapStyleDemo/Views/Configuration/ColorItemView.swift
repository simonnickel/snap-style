//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

struct ColorItemView: View {

    let accent: SnapStyle.Accent
    let selected: Bool

    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(accent.complementary)
                Circle()
                    .fill(accent.contrast)
            }
            .padding(.top, 8)
            RoundedRectangle(cornerRadius: 5)
                .fill(Gradient(colors: [accent.base, accent.complementary]))
                .padding(2)
        }
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(accent.base)
                .stroke(selected ? Color.primary : .clear, lineWidth: 2)
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
