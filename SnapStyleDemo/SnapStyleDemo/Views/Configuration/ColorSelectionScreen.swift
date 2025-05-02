//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapCore

struct ColorSelectionScreen: View {
    
    @Environment(\.configuration) private var configuration
    
    let colors: [Color] = [.red, .green, .blue, .mint, .purple, .pink, .teal, .yellow]
    
    var body: some View {
        
        let gridItem: GridItem = GridItem(.flexible(minimum: 20, maximum: 180))
        
        ScrollView {
            LazyVGrid(columns: [gridItem, gridItem]) {
                ForEach(colors, id: \.self) { color in
                    Button {
                        configuration.accent = color
                    } label: {
                        ColorItemView(color: color, selected: color == configuration.accent)
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
