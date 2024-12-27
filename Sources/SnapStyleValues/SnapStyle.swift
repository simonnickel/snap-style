//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

// TODO: .erase does no longer have meaning

public struct SnapStyle {
    
    public var fonts: [FontKey.ValueKeyPath: [FontKey.ValueBuilder]] = [:]
    public var surfaces: [SurfaceKey.ValueKeyPath: [SurfaceKey.ValueBuilder]] = [:]
    
    // TODO: This should be of reference type, to create new caches on append.
//    private var cacheFonts: [FontKey.ValueKeyPath: ValueContainer<FontKey.Value>] = [:]
//    private var cacheSurfaces: [SurfaceKey.ValueKeyPath: ValueContainer<SurfaceKey.Value>] = [:]

    // TODO: Hide behind private init?
    public init() { }
    
    
    // MARK: - Append
    
    internal mutating func append(fonts: [FontKey.ValueKeyPath: FontKey.ValueBuilder]) {
//        cacheFonts = [:] // TODO: Create new Cache instance.
        append(fonts, type: FontKey.self, at: \.fonts)
    }
    
    internal mutating func append(surfaces: [SurfaceKey.ValueKeyPath: SurfaceKey.ValueBuilder]) {
//        cacheSurfaces = [:] // TODO: Create new Cache instance.
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
