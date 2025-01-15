//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
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
                    NavigationLink("Structure Text") {
                        StructuredTextScreen()
                    }
                } header: {
                    Text("Examples")
                }
                Section {
                    NavigationLink("Numbers") {
                        DebugKeyScreen(keyPath: \.numbers)
                    }
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
                    NavigationLink("Numbers") {
                        DebugCacheScreen<SnapStyle.NumberKey>()
                    }
                    NavigationLink("Fonts") {
                        DebugCacheScreen<SnapStyle.FontKey>()
                    }
                    NavigationLink("Surfaces") {
                        DebugCacheScreen<SnapStyle.SurfaceKey>()
                    }
                } header: {
                    Text("Caches")
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
                \.title : SnapStyle.ValueBuilder.builder { context in
                    switch context.element.hierarchy {
                        case.primary: .definition(.init(size: 12))
                        default: nil
                    }

                }
            ],
            surfaces: [
                \.title : SnapStyle.ValueBuilder.builder { context in
                    switch context.element.hierarchy {
                    case .primary: .surface(.withColor(foreground: .primary))
                    default: nil
                    }
                }
            ]
        )
}
