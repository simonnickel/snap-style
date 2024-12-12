//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleValues
import SnapStyleDebug
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
                        DebugKeyScreen(keyPath: \.fonts)
                    }
                    NavigationLink("Surfaces") {
                        DebugKeyScreen(keyPath: \.surfaces)
                    }
                } header: {
                    Text("Keys")
                }
                Section {
                    NavigationLink("Values") {
                        DebugValueScreen()
                    }
                } header: {
                    Text("Values")
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
