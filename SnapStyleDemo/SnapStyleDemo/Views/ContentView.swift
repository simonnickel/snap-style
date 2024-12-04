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
                        KeyScreen(keys: SnapStyle.ShapeStyleKey.allCases) { key in
                            KeyRowColor(key: key)
                        }
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
}
