//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ContentView: View {
    
    @Environment(\.style) private var style
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("Fonts") {
                        FontExampleScreen()
                    }
                    NavigationLink("Components") {
                        ComponentsScreen()
                    }
                } header: {
                    Text("Examples")
                }
                Section {
                    NavigationLink("Fonts") {
                        KeyScreen(type: SnapStyle.FontKey.self, keyPath: \.fonts) { keyPath in
                            KeyRowFont(keyPath: keyPath)
                        }
                    }
                    NavigationLink("Surfaces") {
                        KeyScreen(type: SnapStyle.SurfaceKey.self, keyPath: \.surfaces) { keyPath in
                            KeyRowSurface(keyPath: keyPath)
                        }
                    }
                    NavigationLink("Values") {
                        DebugValueScreen()
                    }
                } header: {
                    Text("Keys")
                }
            }
        }
    }
    
    struct Row: View {
        let title: String
        var body: some View {
            Text(title)
        }
    }
}

#Preview {
    ContentView()
        .styleOverride(
            fonts: [
                \.title : SnapStyle.ValueBuilder.context { context in
                    switch context.item.hierarchy {
                        case.primary: .definition(.init(size: 12))
                        default: nil
                    }

                }
            ],
            surfaces: [
                \.title : SnapStyle.ValueBuilder.context { context in
                    switch context.item.hierarchy {
                    case .primary: .surface(.withColor(foreground: .primary))
                    default: nil
                    }
                }
            ]
        )
}
