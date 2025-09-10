//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// A value type Container to bundle references to `StyleKey` specific caches.
    internal struct CacheContainer {

        // References to `StyleKey` specific caches.
        internal var numbers: KeyTypeCache<NumberKey> = .init()
        internal var fonts: KeyTypeCache<FontKey> = .init()
        internal var icons: KeyTypeCache<IconKey> = .init()
        internal var surfaces: KeyTypeCache<SurfaceKey> = .init()
        internal var compositions: KeyTypeCache<CompositionKey> = .init()
        internal var accents: KeyTypeCache<AccentKey> = .init()
        internal var shapes: KeyTypeCache<ShapeKey> = .init()

        internal func getCache<Key: StyleKey>() -> KeyTypeCache<Key>? {
            switch Key.self {

                case let key as NumberKey.Type: return numbers as? KeyTypeCache<Key>

                case let key as FontKey.Type: return fonts as? KeyTypeCache<Key>

                case let key as IconKey.Type: return icons as? KeyTypeCache<Key>

                case let key as SurfaceKey.Type: return surfaces as? KeyTypeCache<Key>

                case let key as CompositionKey.Type: return compositions as? KeyTypeCache<Key>
                    
                case let key as AccentKey.Type: return accents as? KeyTypeCache<Key>

                case let key as ShapeKey.Type: return shapes as? KeyTypeCache<Key>

                default: fatalError("Cache is not setup properly.")

            }
        }

        /// Creates a new cache, the old cache will still be in use for a different style definition.
        internal mutating func resetCache<Key: StyleKey>(for: Key.Type) {
            switch Key.self {

                case let key as NumberKey.Type: numbers = .init()

                case let key as FontKey.Type: fonts = .init()

                case let key as IconKey.Type: icons = .init()

                case let key as SurfaceKey.Type:
                    compositions = .init()
                    surfaces = .init()

                case let key as CompositionKey.Type:
                    compositions = .init()
                    surfaces = .init()
                    
                case let key as AccentKey.Type:
                    accents = .init()
                    compositions = .init()
                    surfaces = .init()

                case let key as ShapeKey.Type: shapes = .init()

                default: fatalError("Cache is not setup properly.")

            }
        }

    }


    // MARK: - KeyTypeCache

    package class KeyTypeCache<Key: StyleKey> {

        private var content: [Key.ValueBuilderKeyPath: ValueForContextCache<Key.Value>] = [:]
        package var keys: [Key.ValueBuilderKeyPath] { Array(content.keys) }

        package func getValueCache(for keyPath: KeyPath<Key, Key.ValueBuilder>) -> ValueForContextCache<Key.Value>? {
            return content[keyPath]
        }

        package func getValue(for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: Style.Context) -> Key.Value? {

            if let cache = content[keyPath] {
                return cache.getValue(for: context)
            }

            return nil
        }

        func setValue(_ value: Key.Value, for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: Style.Context) {

            if let cache = content[keyPath] {
                cache.setValue(value, for: context)
            } else {
                let cache: ValueForContextCache<Key.Value> = .init()
                cache.setValue(value, for: context)
                content[keyPath] = cache
            }

        }

    }


    // MARK: - ValueForContextCache

    package class ValueForContextCache<Value> {

        private var content: [Style.Context: Value] = [:]
        package var keys: [Style.Context] { Array(content.keys) }

        package func getValue(for context: Style.Context) -> Value? {
            content[context]
        }

        func setValue(_ value: Value, for context: Style.Context) {
            content[context] = value
        }

    }

}


// MARK: - SnapStyle + Cache

extension Style {


    // MARK: Get & Set

    internal func getValueFromCache<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath, in context: Style.Context) -> Key.Value? {
        guard let cache: KeyTypeCache<Key> = cacheContainer.getCache() else { return nil }

        return cache.getValue(for: keyPath, in: context)
    }

    internal func setValueInCache<Key: StyleKey>(_ value: Key.Value, for keyPath: KeyPath<Key, Key.ValueBuilder>, in context: Style.Context) {
        guard let cache: KeyTypeCache<Key> = cacheContainer.getCache() else { return }

        cache.setValue(value, for: keyPath, in: context)
    }


    // MARK: Debug

    /// For debug purposes.
    package func cachedKeyPaths<Key: StyleKey>(for: Key.Type) -> [Key.ValueBuilderKeyPath] {
        guard
            let cache: KeyTypeCache<Key> = cacheContainer.getCache()
        else { return [] }

        return cache.keys
    }

    /// For debug purposes.
    package func cachedContexts<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath) -> [Style.Context] {
        guard
            let cache: KeyTypeCache<Key> = cacheContainer.getCache(),
            let valueCache = cache.getValueCache(for: keyPath)
        else { return [] }

        return valueCache.keys
    }

    /// For debug purposes.
    package func cachedValue<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath, in context: Style.Context) -> Key.Value? {
        guard
            let cache: KeyTypeCache<Key> = cacheContainer.getCache(),
            let valueCache = cache.getValueCache(for: keyPath)
        else { return nil }

        return valueCache.getValue(for: context)
    }

}
