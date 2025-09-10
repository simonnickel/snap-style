//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    internal struct BuilderContainer: Copyable {

        internal var numbers: [Keys.NumberKey.ValueBuilderKeyPath: [Keys.NumberKey.ValueBuilder]] = [:]
        internal var fonts: [Keys.FontKey.ValueBuilderKeyPath: [Keys.FontKey.ValueBuilder]] = [:]
        internal var icons: [Keys.IconKey.ValueBuilderKeyPath: [Keys.IconKey.ValueBuilder]] = [:]
        internal var surfaces: [Keys.SurfaceKey.ValueBuilderKeyPath: [Keys.SurfaceKey.ValueBuilder]] = [:]
        internal var compositions: [Keys.CompositionKey.ValueBuilderKeyPath: [Keys.CompositionKey.ValueBuilder]] = [:]
        internal var accents: [Keys.AccentKey.ValueBuilderKeyPath: [Keys.AccentKey.ValueBuilder]] = [:]
        internal var shapes: [Keys.ShapeKey.ValueBuilderKeyPath: [Keys.ShapeKey.ValueBuilder]] = [:]


        // MARK: Get

        internal func builder<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath) -> [Key.ValueBuilder] {

            switch keyPath {

                case let keyPath as KeyPath<Keys.NumberKey, Keys.NumberKey.ValueBuilder>:
                    if let builders = numbers[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.FontKey, Keys.FontKey.ValueBuilder>:
                    if let builders = fonts[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.IconKey, Keys.IconKey.ValueBuilder>:
                    if let builders = icons[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.SurfaceKey, Keys.SurfaceKey.ValueBuilder>:
                    if let builders = surfaces[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.CompositionKey, Keys.CompositionKey.ValueBuilder>:
                    if let builders = compositions[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                    
                case let keyPath as KeyPath<Keys.AccentKey, Keys.AccentKey.ValueBuilder>:
                    if let builders = accents[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.ShapeKey, Keys.ShapeKey.ValueBuilder>:
                    if let builders = shapes[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                default: fatalError("Not defined for \(Key.self)")

            }

            return []
        }

    }


    // MARK: Append

    internal func appended(numbers: [Keys.NumberKey.ValueBuilderKeyPath: Keys.NumberKey.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }

    internal func appended(fonts: [Keys.FontKey.ValueBuilderKeyPath: Keys.FontKey.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }

    internal func appended(icons: [Keys.IconKey.ValueBuilderKeyPath: Keys.IconKey.ValueBuilder]) -> Self {
        appended(icons, at: \.icons)
    }

    internal func appended(surfaces: [Keys.SurfaceKey.ValueBuilderKeyPath: Keys.SurfaceKey.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }

    internal func appended(compositions: [Keys.CompositionKey.ValueBuilderKeyPath: Keys.CompositionKey.ValueBuilder]) -> Self {
        appended(compositions, at: \.compositions)
    }

    internal func appended(accents: [Keys.AccentKey.ValueBuilderKeyPath: Keys.AccentKey.ValueBuilder]) -> Self {
        appended(accents, at: \.accents)
    }

    internal func appended(shapes: [Keys.ShapeKey.ValueBuilderKeyPath: Keys.ShapeKey.ValueBuilder]) -> Self {
        appended(shapes, at: \.shapes)
    }

    private func appended<Key: StyleKey>(_ keyPaths: [Key.ValueBuilderKeyPath: Key.ValueBuilder], at destination: WritableKeyPath<Style.BuilderContainer, [Key.ValueBuilderKeyPath: [Key.ValueBuilder]]>) -> Self {

        var copy = self
        copy.cacheContainer.resetCache(for: Key.self)

        for (keyPath, valueBuilder) in keyPaths {

            var builders = self.builderContainer[keyPath: destination][keyPath] ?? []
            builders.append(valueBuilder)
            copy.builderContainer[keyPath: destination][keyPath] = builders

        }

        return copy
    }
}
