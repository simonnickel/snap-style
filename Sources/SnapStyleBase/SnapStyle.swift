//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct SnapStyle {
    
    public var numbers: [NumberKey.ValueBuilderKeyPath: [NumberKey.ValueBuilder]] = [:]
    public var fonts: [FontKey.ValueBuilderKeyPath: [FontKey.ValueBuilder]] = [:]
    public var colors: [ColorKey.ValueBuilderKeyPath: [ColorKey.ValueBuilder]] = [:]
    public var surfaces: [SurfaceKey.ValueBuilderKeyPath: [SurfaceKey.ValueBuilder]] = [:]
    public var shapes: [ShapeKey.ValueBuilderKeyPath: [ShapeKey.ValueBuilder]] = [:]
    
    internal var cacheNumbers: KeyTypeCache<NumberKey> = .init()
    internal var cacheFonts: KeyTypeCache<FontKey> = .init()
    internal var cacheColors: KeyTypeCache<ColorKey> = .init()
    internal var cacheSurfaces: KeyTypeCache<SurfaceKey> = .init()
    internal var cacheShapes: KeyTypeCache<ShapeKey> = .init()
    
    public init() {}
    
    
    // MARK: - Append
    
    internal func appended(numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }
    
    internal func appended(fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }
    
    internal func appended(colors: [ColorKey.ValueBuilderKeyPath: ColorKey.ValueBuilder]) -> Self {
        appended(colors, at: \.colors)
    }
    
    internal func appended(surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }
    
    internal func appended(shapes: [ShapeKey.ValueBuilderKeyPath: ShapeKey.ValueBuilder]) -> Self {
        appended(shapes, at: \.shapes)
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
