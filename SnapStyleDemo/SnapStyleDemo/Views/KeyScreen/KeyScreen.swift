//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct KeyScreen<Key, ItemContent: View>: View where Key: Hashable, Key : CustomStringConvertible {
    
    let keys: [Key]
    
    let content: (Key) -> ItemContent
    
    var body: some View {
        List(keys, id: \.self, rowContent: content)
    }
    
}

#Preview {
    KeyScreen(keys: SnapStyle.ShapeStyleKey.allCases) { key in
        KeyRowColor(key: key)
    }
}
