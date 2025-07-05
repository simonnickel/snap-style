//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyle
import SwiftUI

struct ConfigurationColorScreen: View {

    @Environment(\.self) private var environment
    @Environment(\.demoConfiguration) private var demoConfiguration

    var body: some View {

        // TODO: Define Colors with variants.
        // TODO: Add default color variant generator.
        let accents: [SnapStyle.Accent] = [
            .fallback,
            .init(
                base: .green,
                onAccent: Color.white,
                complementary: .green.adjusted(hue: .add(0.06), in: environment),
                contrast: .green.adjusted(hue: .add(0.5), in: environment),
                brightness: .dark
            ),
            .init(
                base: .blue,
                onAccent: Color.white,
                complementary: .blue.adjusted(hue: .add(0.06), in: environment),
                contrast: .blue.adjusted(hue: .add(0.5), in: environment),
                brightness: .dark
            ),
            .init(
                base: .red,
                onAccent: Color.white,
                complementary: .red.adjusted(hue: .add(0.06), in: environment),
                contrast: .red.adjusted(hue: .add(0.5), in: environment),
                brightness: .dark
            ),
            .init(
                base: .yellow,
                onAccent: Color.white,
                complementary: .yellow.adjusted(hue: .add(0.06), in: environment),
                contrast: .yellow.adjusted(hue: .add(0.5), in: environment),
                brightness: .light
            ),
        ]
        let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: 180))

        StyleScreen {
            LazyVGrid(columns: [gridItem, gridItem]) {
                ForEach(accents, id: \.self) { accent in
                    Button {
                        demoConfiguration.accent = accent
                    } label: {
                        ColorItemView(accent: accent, selected: accent == demoConfiguration.accent)
                            .style(accent: accent)
                    }
                }
            }
            .padding()
        }

    }
}


// MARK: - Preview

#Preview {
    ConfigurationColorScreen()
}
