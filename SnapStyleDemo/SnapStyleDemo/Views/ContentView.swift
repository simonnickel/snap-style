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
                        KeyScreen(keys: SnapStyle.FontKey.allCases) { key in
                            KeyRowFont(key: key)
                        }
                    }
                    NavigationLink("Colors") {
                        KeyScreen(keys: SnapStyle.SurfaceKey.allCases) { key in
                            KeyRowSurface(key: key)
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
                .title : SnapStyle.ValueBuilder { context in
                    switch context.item.hierarchy {
                        case.primary: .definition(.init(size: 12))
                        default: nil
                    }

                }
            ],
            surfaces: [
                .title : SnapStyle.ValueBuilder { context in
                    switch context.item.hierarchy {
                    case .primary: .surface(.init(foreground: Color.primary))
                    default: nil
                    }
                }
            ]
        )
}
