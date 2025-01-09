//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    package func cache<KeyType>() -> KeyTypeCache<KeyType>? where KeyType: StyleKey {
        switch KeyType.self {
                
                // TODO: does casting work?
            case let key as FontKey.Type: return cacheFonts as? KeyTypeCache<KeyType>
                
            case let key as SurfaceKey.Type: return cacheSurfaces as? KeyTypeCache<KeyType>
                
            default: fatalError("Cache is not setup properly.")

        }
    }
     
}
