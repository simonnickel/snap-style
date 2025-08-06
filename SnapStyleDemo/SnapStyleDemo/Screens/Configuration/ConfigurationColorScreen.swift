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
            .blue,
            .green,
            .teal,
            .red,
            .orange,
            .yellow,
            .mint,
            .cyan,
            .purple,
            .indigo,
        ]
        let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: .infinity))

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
