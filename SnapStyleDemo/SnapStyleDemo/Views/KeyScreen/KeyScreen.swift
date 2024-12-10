//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyScreen<KeyType: StyleKey, Value, ValueKeyPath, ItemContent: View>: View where Value == KeyType.Value, ValueKeyPath == KeyType.ValueKeyPath {
    
    @Environment(\.style) private var style
    
    let type: KeyType.Type

    let keyPath: KeyPath<SnapStyle, [ValueKeyPath: SnapStyle.ValueContainer<Value>]>
    
    let content: (ValueKeyPath) -> ItemContent
    
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
