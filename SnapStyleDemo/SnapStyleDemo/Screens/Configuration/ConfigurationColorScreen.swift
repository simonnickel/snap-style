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
        let accentPairs: [SnapStyle.Accent.Pair] = [
            .init(.blue, .fallbackAlternative),
            .init(.blue, .yellow),
            .init(.green, .fallbackAlternative),
            .init(.green, .cyan),
            .init(.teal, .fallbackAlternative),
            .init(.teal, .yellow),
            .init(.red, .fallbackAlternative),
            .init(.red, .yellow),
            .init(.orange, .fallbackAlternative),
            .init(.yellow, .fallbackAlternative),
            .init(.mint, .fallbackAlternative),
            .init(.cyan, .fallbackAlternative),
            .init(.purple, .fallbackAlternative),
            .init(.indigo, .fallbackAlternative),
            .init(.fallback, .fallbackAlternative),
        ]
        let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: .infinity))

        StyleScreen {
            LazyVGrid(columns: [gridItem, gridItem]) {
                ForEach(accentPairs, id: \.self) { accents in
                    Button {
                        demoConfiguration.accents = accents
                    } label: {
                        ColorItemView(accent: accents.accent, selected: accents == demoConfiguration.accents)
                            .style(accent: accents.accent, alternative: accents.alternative)
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
