//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapCore
import SnapStyleBase

struct ColorSelectionScreen: View {
    
    @Environment(\.self) var environment
    @Environment(\.configuration) private var configuration
    
    var body: some View {
        
        let accents: [SnapStyle.Accent] = [
            .fallback,
            .init(base: .green, complementary: .green.adjusted(hue: .add(0.06), in: environment), contrast: .green.adjusted(hue: .add(0.5), in: environment)),
            .init(base: .blue, complementary: .blue.adjusted(hue: .add(0.06), in: environment), contrast: .blue.adjusted(hue: .add(0.5), in: environment)),
            .init(base: .red, complementary: .red.adjusted(hue: .add(0.06), in: environment), contrast: .red.adjusted(hue: .add(0.5), in: environment))
        ]
        let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: 180))
        
        ScrollView {
            LazyVGrid(columns: [gridItem, gridItem]) {
                ForEach(accents, id: \.self) { accent in
                    Button {
                        configuration.accent = accent
                    } label: {
                        ColorItemView(accent: accent, selected: accent == configuration.accent)
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
