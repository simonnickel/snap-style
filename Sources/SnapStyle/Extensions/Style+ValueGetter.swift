//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    
    // MARK: - Font
    
    internal func font(for key: FontKey, in context: SnapStyle.Context) -> Font? {

        guard let values = fonts[key] else {
            return nil
        }

        let value = values.value(for: context)

        switch value {
            case .reference(let key): return font(for: key, in: context)
            default: return value?.wrappedValue
        }
        
    }

    
    // MARK: - Surface
    
    internal func surface(layer: SnapStyle.SurfaceKey.Layer, for key: SurfaceKey, in context: Context) -> AnyShapeStyle? {

        guard let values = surfaces[key] else {
            return nil
        }

        let value = values.value(for: context)

        switch value {
            case .reference(let key): return surface(layer: layer, for: key, in: context)
            default: return value?.wrappedValue.surface(for: layer)
        }
        
    }

}
