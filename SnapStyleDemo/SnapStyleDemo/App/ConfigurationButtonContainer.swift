//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ConfigurationButtonContainer<Content: View>: View {

    @State private var showSheet: Bool = false
    @State private var presentationDetentSelected: PresentationDetent = .medium
    
    let content: () -> Content

    var body: some View {
        ZStack {
            content()

            ZStack {
                StyleButton(.component(.buttonIconOnly)) {
                    showSheet.toggle()
                } content: {
                    Image(systemName: "slider.horizontal.3")
                }
                .style(padding: \.paddingScreenHorizontal)
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
    ConfigurationButtonContainer() {
        Text("Content")
    }
}
