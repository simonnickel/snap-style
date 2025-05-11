//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ContentListScreen: View {
    
    var body: some View {
        StyleList {
            ListSection(title: "Components", screens: [.content, .card, .list, .action, .componentStack])
            ListSection(title: "Examples", screens: [.components, .structured])
            ListSection(title: "Compon", screens: [.elements])
            ListSection(title: "Caches", screens: [.cacheNumber, .cacheFont, .cacheSurface, .cacheComposition])
        }
    }
    
    
    // MARK: - ListSection
    
    struct ListSection: View {
        
        let title: String
        let screens: [ContentFlow.Screen]
        
        var body: some View {
            Section {
                ForEach(screens, id: \.self) { screen in
                    ListRow(screen: screen)
                }
            } header: {
                Text(title)
            }
        }
    }
    
    
    // MARK: - ListRow
    
    struct ListRow: View {
        
        let screen: ContentFlow.Screen
        
        var body: some View {
            NavigationLink(value: screen) {
                Text(screen.title)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    ContentListScreen()
}
