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
                    NavigationLink("Components") {
                        ComponentsScreen()
                    }
                    NavigationLink("Structured") {
                        StructuredScreen()
                    }
                    NavigationLink("List Native") {
                        ListNativeScreen()
                    }
                    NavigationLink("List Inline") {
                        ListInlineScreen()
                    }
                } header: {
                    Text("Examples")
                }
                Section {
                    NavigationLink("Buttons") {
                        ButtonsScreen()
                    }
                    NavigationLink("Elements") {
                        DebugKeyScreen()
                    }
                } header: {
                    Text("Components")
                }
                Section {
                    NavigationLink("Numbers") {
                        DebugCacheScreen<SnapStyle.NumberKey>()
                    }
                    NavigationLink("Fonts") {
                        DebugCacheScreen<SnapStyle.FontKey>()
                    }
                    NavigationLink("Colors") {
                        DebugCacheScreen<SnapStyle.ColorKey>()
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
                        case.primary: .definition(.with(size: 12))
                        default: nil
                    }

                }
            ]
        )
}
