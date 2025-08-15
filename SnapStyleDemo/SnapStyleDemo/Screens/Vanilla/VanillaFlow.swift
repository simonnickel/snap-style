//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

struct VanillaFlow: View {

    @MainActor
    enum Screen: Hashable, Equatable {
        case root
        
        case rectangle
        case triangle
        case circle
        
        case color(Color)
        
        /// A generic destination to navigate to.
        case destination(String, icon: String)

        @ViewBuilder
        var screen: some View {
            Group {
                switch self {
                    case .root: VanillaContentListScreen()
                        
                    case .rectangle, .triangle, .circle: VanillaListScreen()
                        
                    case .color(let color): VanillaColorScreen(color: color)
                        
                    case .destination(_, _):
                        VanillaListScreen()
                }
            }
            .navigationTitle(title)
#if !os(macOS) // TODO feature: platform agnostic placement
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
#endif
        }
        
        var title: String {
            switch self {
                case .root: "Vanilla Demo"
                    
                case .rectangle: "Rectangle"
                case .triangle: "Triangle"
                case .circle: "Circle"
                    
                case .color(_): "Color"
                    
                case .destination(let title, _): title
            }
        }
        
        var icon: String {
            switch self {
                case .root: "list"
                    
                case .rectangle: "rectangle"
                case .triangle: "triangle"
                case .circle: "circle"
                    
                case .color(_): "swatchpalette"
                    
                case .destination(_, let icon): icon
            }
        }
    }
    
    let root: Screen

    @State private var showSettings: Bool = false

    var body: some View {
        
        VanillaFloatingButtonContainer {
            NavigationStack {
                root.screen
                    .navigationDestination(for: Screen.self) { screen in
                        screen.screen
                    }
#if !os(macOS) // TODO feature: platform agnostic placement
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                showSettings.toggle()
                            } label: {
                                Label("Settings", systemImage: "gear")
                            }
                        }
                    }
#endif
            }
            .sheet(isPresented: $showSettings) {
                VanillaFlow(root: .root)
            }
        }
        
    }

}


// MARK: - Preview

#Preview {
    VanillaFlow(root: .root)
}
