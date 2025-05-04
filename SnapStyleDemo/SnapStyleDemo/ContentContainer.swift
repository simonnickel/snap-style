//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ContentContainer: View {
    
    @State private var isPresented: Bool = false
    @State private var presentationDetentSelected: PresentationDetent = .medium
    
    var body: some View {
        ZStack {
            ContentFlow()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    StyleButton {
                        isPresented.toggle()
                    } content: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                .style(padding: \.paddingScreenHorizontal)
            }
        }
        .sheet(isPresented: $isPresented) {
            ConfigurationFlow()
                .presentationDetents([.medium, .height(50), .large], selection: $presentationDetentSelected)
        }
    }
    
}


// MARK: - Preview

#Preview {
    ContentContainer()
}
