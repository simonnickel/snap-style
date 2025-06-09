//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationButtonContainer: View {

    @State private var isPresented: Bool = false
    @State private var presentationDetentSelected: PresentationDetent = .medium

    var body: some View {
        ZStack {
            ContentFlow()

            ZStack {
                StyleButton(.component(.actionIcon)) {
                    isPresented.toggle()
                } content: {
                    Image(systemName: "slider.horizontal.3")
                }
                .style(padding: \.insetScreenHorizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .sheet(isPresented: $isPresented) {
            ConfigurationFlow()
                .presentationDetents([.medium, .height(50), .large], selection: $presentationDetentSelected)
        }
    }

}


// MARK: - Preview

#Preview {
    ConfigurationButtonContainer()
}
