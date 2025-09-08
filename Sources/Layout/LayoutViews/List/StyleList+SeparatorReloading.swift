//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

// TODO FB: Updating the `.listRowSeparatorLeading` alignment guide should work.
// TODO: Not necessary on iOS 18, move into separate file
struct SeparatorReloadingList<Content: View>: View {
    
    @Environment(\.style) private var style
    @Environment(\.listIconWidth) private var listIconWidth
    
    @State private var valueRendered: CGFloat = -1
    
    let content: () -> Content
    
    var body: some View {
        if #available(iOS 26, *) {
            SeparatorReloadingList26(content: content)
        } else {
            SeparatorReloadingList18(content: content)
        }
    }
}

// TODO: Why does it not work in ConfigurationSheet?
struct SeparatorReloadingList26<Content: View>: View {
    
    @Environment(\.style) private var style
    @Environment(\.listIconWidth) private var listIconWidth
    
    @State private var valueRendered: CGFloat = -1
    
    let content: () -> Content
    
    var body: some View {
        if valueRendered == listIconWidth {
            List {
                content()
                    .alignmentGuide(.listRowSeparatorLeading) { d in
                        let padding = style.number(for: \.paddingListRowLeading) ?? 0
                        print("Alignment Guide set: \(listIconWidth)")
                        return listIconWidth == 0 ? padding : listIconWidth + padding + padding
                    }
            }
        } else {
            Color.clear
                .onAppear {
                    print("FB: List was rerendered to fix separator insets. Rendered: \(valueRendered), actual: \(listIconWidth)") // TODO FB: Enter FB number
                    valueRendered = listIconWidth
                }
        }
    }
}

struct SeparatorReloadingList18<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
        List {
            content()
        }
    }
}
