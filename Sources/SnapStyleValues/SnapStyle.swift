//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    public var fonts: [FontKey.ValueKeyPath: [FontKey.ValueBuilder]] = [:]
    public var surfaces: [SurfaceKey.ValueKeyPath: [SurfaceKey.ValueBuilder]] = [:]
    
    internal var cacheFonts: KeyTypeCache<FontKey> = .init()
    internal var cacheSurfaces: KeyTypeCache<SurfaceKey> = .init()
    
    
    // MARK: - Append
    
    internal mutating func append(fonts: [FontKey.ValueKeyPath: FontKey.ValueBuilder]) {
        cacheFonts = .init() // Reset cache
        append(fonts, at: \.fonts)
    }
    
    internal mutating func append(surfaces: [SurfaceKey.ValueKeyPath: SurfaceKey.ValueBuilder]) {
        cacheSurfaces = .init() // Reset cache
        append(surfaces, at: \.surfaces)
    }
    
    private mutating func append<KeyType: StyleKey>(_ keyPaths: [KeyType.ValueKeyPath: KeyType.ValueBuilder], at destination: WritableKeyPath<SnapStyle, [KeyType.ValueKeyPath: [KeyType.ValueBuilder]]>) {
        
        for (keyPath, valueBuilder) in keyPaths {
            
            var builders = self[keyPath: destination][keyPath] ?? []
            builders.append(valueBuilder)
            self[keyPath: destination][keyPath] = builders
            
        }
        
    }

}
