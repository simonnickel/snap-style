//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    public var numbers: [NumberKey.ValueKeyPath: [NumberKey.ValueBuilder]] = [:]
    public var fonts: [FontKey.ValueKeyPath: [FontKey.ValueBuilder]] = [:]
    public var surfaces: [SurfaceKey.ValueKeyPath: [SurfaceKey.ValueBuilder]] = [:]
    
    internal var cacheNumbers: KeyTypeCache<NumberKey> = .init()
    internal var cacheFonts: KeyTypeCache<FontKey> = .init()
    internal var cacheSurfaces: KeyTypeCache<SurfaceKey> = .init()
    
    public init() {}
    
    
    // MARK: - Append
    
    internal func append(numbers: [NumberKey.ValueKeyPath: NumberKey.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }
    
    internal func append(fonts: [FontKey.ValueKeyPath: FontKey.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }
    
    internal func append(surfaces: [SurfaceKey.ValueKeyPath: SurfaceKey.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }
    
    private func appended<Key: StyleKey>(_ keyPaths: [Key.ValueKeyPath: Key.ValueBuilder], at destination: WritableKeyPath<SnapStyle, [Key.ValueKeyPath: [Key.ValueBuilder]]>) -> Self {
        
        var style = self
        style.resetCache(for: Key.self)
        
        for (keyPath, valueBuilder) in keyPaths {
            
            var builders = self[keyPath: destination][keyPath] ?? []
            builders.append(valueBuilder)
            style[keyPath: destination][keyPath] = builders
            
        }
        
        return style
    }
    
}
