//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

// TODO: Move to package?
struct KeyScreen<KeyType: StyleKey, ItemContent: View>: View {
    
    @Environment(\.style) private var style
    
    let type: KeyType.Type

    let keyPath: KeyPath<SnapStyle, [KeyType.ValueKeyPath: SnapStyle.ValueContainer<KeyType.Value>]>
    
    let content: (KeyType.ValueKeyPath) -> ItemContent
    
    var body: some View {
        let items = Array(style[keyPath: keyPath].keys)
        
        return List(items, id: \.self, rowContent: content)
    }
    
}

#Preview {
    KeyScreen(type: SnapStyle.SurfaceKey.self, keyPath: \.surfaces) { keyPath in
        KeyRowSurface(keyPath: keyPath)
    }
}
