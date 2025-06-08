//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI

struct ColorSelectionScreen: View {

    @Environment(\.self) private var environment
    @Environment(\.demoConfiguration) private var demoConfiguration

    var body: some View {

        let accents: [SnapStyle.Accent] = [
            .fallback,
            .init(
                base: .green,
                complementary: .green.adjusted(hue: .add(0.06), in: environment),
                contrast: .green.adjusted(hue: .add(0.5), in: environment),
                brightness: .dark
            ),
            .init(
                base: .blue,
                complementary: .blue.adjusted(hue: .add(0.06), in: environment),
                contrast: .blue.adjusted(hue: .add(0.5), in: environment),
                brightness: .dark
            ),
            .init(
                base: .red,
                complementary: .red.adjusted(hue: .add(0.06), in: environment),
                contrast: .red.adjusted(hue: .add(0.5), in: environment),
                brightness: .dark
            ),
        ]
        let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: 180))

        ScrollView {
            LazyVGrid(columns: [gridItem, gridItem]) {
                ForEach(accents, id: \.self) { accent in
                    Button {
                        demoConfiguration.accent = accent
                    } label: {
                        ColorItemView(accent: accent, selected: accent == demoConfiguration.accent)
                    }
                }
            }
            .padding()
        }

    }
}


// MARK: - Preview

#Preview {
    ColorSelectionScreen()
}
