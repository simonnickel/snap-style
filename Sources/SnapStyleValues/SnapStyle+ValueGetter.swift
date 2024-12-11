//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    
    // MARK: - Font
    
    package func font(for keyPath: FontKey.ValueKeyPath, in context: SnapStyle.Context) -> Font? {

        guard let values = fonts[keyPath] else {
            return nil
        }

        let value = values.value(for: context)

        switch value {
            case .reference(let key): return font(for: key, in: context)
            default: return value?.wrappedValue
        }
        
    }

    
    // MARK: - Surface
    
    package func surface(layer: SnapStyle.SurfaceKey.Layer, for keyPath: SurfaceKey.ValueKeyPath, in context: Context) -> AnyShapeStyle? {

        guard let values = surfaces[keyPath] else {
            return nil
        }

        let value = values.value(for: context)

        switch value {
            case .reference(let key): return surface(layer: layer, for: key, in: context)
            default: return value?.wrappedValue.surface(for: layer)
        }
        
    }

}
