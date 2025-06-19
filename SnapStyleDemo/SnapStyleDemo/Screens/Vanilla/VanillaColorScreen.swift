//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct VanillaColorScreen: View {
    
    let color: Color
    
    var body: some View {
        ScrollView {
            color
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
        .background(color)
    }
}


// MARK: - Preview

#Preview {
    VanillaColorScreen(color: .yellow)
}
