//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct ColorItemView: View {
    
    @Environment(\.self) var environment
    
    let color: Color
    let selected: Bool
    
    var body: some View {
        let colorComplement: Color = color.adjusted(hue: .add(0.06), in: environment)
        VStack {
            HStack {
                Circle()
                    .fill(colorComplement)
                Circle()
                    .fill(color)
                    .colorInvert()
            }
            .padding(.top, 8)
            RoundedRectangle(cornerRadius: 5)
                .fill(Gradient(colors: [color, colorComplement]))
                .padding(2)
        }
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .stroke(selected ? Color.primary : .clear, lineWidth: 2)
        }
    }
}


// MARK: - Preview

#Preview {
    VStack {
        ColorItemView(color: .green, selected: false)
            .frame(width: 200, height: 200)
        ColorItemView(color: .green, selected: true)
            .frame(width: 200, height: 200)
    }
}
