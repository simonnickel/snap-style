//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    public var numbers: [NumberKey.ValueBuilderKeyPath: [NumberKey.ValueBuilder]] = [:]
    public var fonts: [FontKey.ValueBuilderKeyPath: [FontKey.ValueBuilder]] = [:]
    public var surfaces: [SurfaceKey.ValueBuilderKeyPath: [SurfaceKey.ValueBuilder]] = [:]
    
    internal var cacheNumbers: KeyTypeCache<NumberKey> = .init()
    internal var cacheFonts: KeyTypeCache<FontKey> = .init()
    internal var cacheSurfaces: KeyTypeCache<SurfaceKey> = .init()
    
    public init() {}
    
    
    // MARK: - Append
    
    internal func append(numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }
    
    internal func append(fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }
    
    internal func append(surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }
    
    private func appended<Key: StyleKey>(_ keyPaths: [Key.ValueBuilderKeyPath: Key.ValueBuilder], at destination: WritableKeyPath<SnapStyle, [Key.ValueBuilderKeyPath: [Key.ValueBuilder]]>) -> Self {
        
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
