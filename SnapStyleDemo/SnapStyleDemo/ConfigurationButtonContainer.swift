//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationButtonContainer: View {

    @State private var showSheet: Bool = false
    @State private var presentationDetentSelected: PresentationDetent = .medium

    var body: some View {
        ZStack {
            TabContainer()

            ZStack {
                StyleButton(.component(.actionIcon)) {
                    showSheet.toggle()
                } content: {
                    Image(systemName: "slider.horizontal.3")
                }
                .style(padding: \.insetScreenHorizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .sheet(isPresented: $showSheet) {
            ConfigurationFlow()
                .presentationDetents([.medium, .height(50), .large], selection: $presentationDetentSelected)
        }
    }

}


// MARK: - Preview

#Preview {
    ConfigurationButtonContainer()
}
