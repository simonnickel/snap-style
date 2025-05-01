//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    func setupNavigationToolbar() -> some View {
        self
            .modifier(ToolbarModifier())
    }
    
}

internal struct ToolbarModifier: ViewModifier {
    
    @State private var isPresented: Bool = false
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Label("Style", systemImage: "slider.horizontal.3")
                    }
                    .popover(isPresented: $isPresented, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                        PopoverContentView()
                            .presentationCompactAdaptation(.popover)
                    }
                    
                }
            }
    }
    
}


struct PopoverContentView: View {
    var body: some View {
        Text("Popover content")
            .padding()
    }
}
