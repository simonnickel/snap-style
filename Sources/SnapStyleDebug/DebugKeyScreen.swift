//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

public struct DebugKeyScreen<KeyType: StyleKey>: View {
    
    @Environment(\.style) private var style

    public typealias ItemKeyPath = KeyPath<SnapStyle, [KeyType.ValueKeyPath: SnapStyle.ValueContainer<KeyType.Value>]>
    
    let keyPath: ItemKeyPath
    
    public init(keyPath: ItemKeyPath) {
        self.keyPath = keyPath
    }
        
    public var body: some View {
        let keyPaths = Array(style[keyPath: keyPath].keys)
        
        return List(keyPaths, id: \.self) { keyPath in
            KeyType.row(keyPath: keyPath)
        }

    }
    
}

extension StyleKey {
    
    @MainActor
    @ViewBuilder
    static func row(keyPath: ValueKeyPath) -> some View {

        // TODO: Is there a simpler solution without casting?
        switch self {
            case is SnapStyle.FontKey.Type: DebugKeyRowFont(keyPath: keyPath as! SnapStyle.FontKey.ValueKeyPath)
            case is SnapStyle.SurfaceKey.Type: DebugKeyRowSurface(keyPath: keyPath as! SnapStyle.SurfaceKey.ValueKeyPath)
            default: Text("Test")
        }
        
    }
    
}

#Preview {
    DebugKeyScreen(keyPath: \.surfaces)
}
