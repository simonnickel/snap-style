//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension SnapStyle {
    
    internal struct BuilderContainer: Copyable {
        
        internal var numbers: [NumberKey.ValueBuilderKeyPath: [NumberKey.ValueBuilder]] = [:]
        internal var fonts: [FontKey.ValueBuilderKeyPath: [FontKey.ValueBuilder]] = [:]
        internal var icons: [IconKey.ValueBuilderKeyPath: [IconKey.ValueBuilder]] = [:]
        internal var surfaces: [SurfaceKey.ValueBuilderKeyPath: [SurfaceKey.ValueBuilder]] = [:]
        internal var compositions: [CompositionKey.ValueBuilderKeyPath: [CompositionKey.ValueBuilder]] = [:]
        internal var shapes: [ShapeKey.ValueBuilderKeyPath: [ShapeKey.ValueBuilder]] = [:]
        
        internal func builder<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath) -> [Key.ValueBuilder] {
            
            switch keyPath {
                
                case let keyPath as KeyPath<NumberKey, NumberKey.ValueBuilder>:
                    if let builders = numbers[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                    
                case let keyPath as KeyPath<FontKey, FontKey.ValueBuilder>:
                    if let builders = fonts[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                    
                case let keyPath as KeyPath<IconKey, IconKey.ValueBuilder>:
                    if let builders = icons[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                
                case let keyPath as KeyPath<SurfaceKey, SurfaceKey.ValueBuilder>:
                    if let builders = surfaces[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                
                case let keyPath as KeyPath<CompositionKey, CompositionKey.ValueBuilder>:
                    if let builders = compositions[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                
                case let keyPath as KeyPath<ShapeKey, ShapeKey.ValueBuilder>:
                    if let builders = shapes[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                
                default: fatalError("Not defined for \(Key.self)")
                    
            }
            
            return []
        }
        
    }
    
    
    // MARK: - Append
    
    internal func appended(numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }
    
    internal func appended(fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }
    
    internal func appended(icons: [IconKey.ValueBuilderKeyPath: IconKey.ValueBuilder]) -> Self {
        appended(icons, at: \.icons)
    }
    
    internal func appended(surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }
    
    internal func appended(compositions: [CompositionKey.ValueBuilderKeyPath: CompositionKey.ValueBuilder]) -> Self {
        appended(compositions, at: \.compositions)
    }
    
    internal func appended(shapes: [ShapeKey.ValueBuilderKeyPath: ShapeKey.ValueBuilder]) -> Self {
        appended(shapes, at: \.shapes)
    }
    
    private func appended<Key: StyleKey>(_ keyPaths: [Key.ValueBuilderKeyPath: Key.ValueBuilder], at destination: WritableKeyPath<SnapStyle.BuilderContainer, [Key.ValueBuilderKeyPath: [Key.ValueBuilder]]>) -> Self {
        
        var style = self
        style.cacheContainer.resetCache(for: Key.self)
        
        for (keyPath, valueBuilder) in keyPaths {
            
            var builders = self.builderContainer[keyPath: destination][keyPath] ?? []
            builders.append(valueBuilder)
            style.builderContainer[keyPath: destination][keyPath] = builders
            
        }
        
        return style
    }
}
