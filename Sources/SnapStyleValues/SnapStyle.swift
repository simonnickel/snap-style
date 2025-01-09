//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    public var fonts: [FontKey.ValueKeyPath: [FontKey.ValueBuilder]] = [:]
    public var surfaces: [SurfaceKey.ValueKeyPath: [SurfaceKey.ValueBuilder]] = [:]
    
    internal var cacheFonts: ValueCache<FontKey> = .init()
    internal var cacheSurfaces: ValueCache<SurfaceKey> = .init()

    // TODO: Hide behind private init?
    public init() { }
    
    
    // MARK: - Append
    
    internal mutating func append(fonts: [FontKey.ValueKeyPath: FontKey.ValueBuilder]) {
        cacheFonts = .init() // Reset cache
        append(fonts, type: FontKey.self, at: \.fonts)
    }
    
    internal mutating func append(surfaces: [SurfaceKey.ValueKeyPath: SurfaceKey.ValueBuilder]) {
        cacheSurfaces = .init() // Reset cache
        append(surfaces, type: SurfaceKey.self, at: \.surfaces)
    }
    
    private mutating func append<KeyType: StyleKey>(_ keyPaths: [KeyType.ValueKeyPath: KeyType.ValueBuilder], type: KeyType.Type, at destination: WritableKeyPath<SnapStyle, [KeyType.ValueKeyPath: [KeyType.ValueBuilder]]>) {
        
        for (keyPath, valueBuilder) in keyPaths {
            
            var builders = self[keyPath: destination][keyPath] ?? []
            builders.append(valueBuilder)
            self[keyPath: destination][keyPath] = builders
            
        }
        
    }

}
