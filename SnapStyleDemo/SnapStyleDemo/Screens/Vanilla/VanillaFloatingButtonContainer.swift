//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct VanillaFloatingButtonContainer<Content: View>: View {

    @State private var isPresented: Bool = false
    @State private var presentationDetentSelected: PresentationDetent = .medium
    
    let content: () -> Content

    var body: some View {
        ZStack {
            content()

            ZStack {
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .buttonStyle(.plain)
                .padding()
//                .glassEffect(.regular.tint(.yellow).interactive(), in: Circle())
                .scenePadding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .sheet(isPresented: $isPresented) {
            VanillaFlow(root: .root)
                .presentationDetents([.medium, .height(50), .large], selection: $presentationDetentSelected)
        }
    }

}


// MARK: - Preview

#Preview {
    VanillaFloatingButtonContainer {
        VStack {
            Text("Content")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
