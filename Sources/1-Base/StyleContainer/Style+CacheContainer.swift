//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// A Container to bundle references to `StyleAttribute` specific caches.
    /// It is a struct to easily be copied when definitions branch off in the view hierarchy.
    internal struct CacheContainer {

        // References to `StyleAttribute` specific caches.
        internal var numbers: AttributeTypeCache<Attribute.Number> = .init()
        internal var paddings: AttributeTypeCache<Attribute.Padding> = .init()
        internal var fonts: AttributeTypeCache<Attribute.Font> = .init()
        internal var icons: AttributeTypeCache<Attribute.Icon> = .init()
        internal var surfaces: AttributeTypeCache<Attribute.Surface> = .init()
        internal var compositions: AttributeTypeCache<Attribute.Composition> = .init()
        internal var accents: AttributeTypeCache<Attribute.Accent> = .init()
        internal var shapes: AttributeTypeCache<Attribute.Shape> = .init()

        internal func getCache<Attribute: StyleAttribute>() -> AttributeTypeCache<Attribute>? {
            switch Attribute.self {

                case is Style.Attribute.Number.Type: return numbers as? AttributeTypeCache<Attribute>
                
                case is Style.Attribute.Padding.Type: return paddings as? AttributeTypeCache<Attribute>

                case is Style.Attribute.Font.Type: return fonts as? AttributeTypeCache<Attribute>

                case is Style.Attribute.Icon.Type: return icons as? AttributeTypeCache<Attribute>

                case is Style.Attribute.Surface.Type: return surfaces as? AttributeTypeCache<Attribute>

                case is Style.Attribute.Composition.Type: return compositions as? AttributeTypeCache<Attribute>

                case is Style.Attribute.Accent.Type: return accents as? AttributeTypeCache<Attribute>

                case is Style.Attribute.Shape.Type: return shapes as? AttributeTypeCache<Attribute>

                default: fatalError("Cache is not setup properly.")

            }
        }

        /// Creates a new cache, the old cache will still be in use for a different style definition.
        ///
        /// When a `Value` stores references to another attribute's key paths (not resolved
        /// values), its cache is independent — the referenced value is resolved separately at
        /// access time, so only the directly changed attribute's cache needs resetting.
        ///
        /// When a `ValueBuilder` uses `builderWrapper` to access another attribute and the
        /// resolved result is cached, changing that other attribute stales the cached value.
        /// Surface values can depend on Accent (via `builderWrapper`), so an Accent reset
        /// must also reset the Surface cache.
        internal mutating func resetCache<Attribute: StyleAttribute>(for: Attribute.Type) {
            switch Attribute.self {

                // Referenced by Padding (key path refs, not resolved values).
                case is Style.Attribute.Number.Type: numbers = .init()

                // References Number (key path refs, not resolved values).
                case is Style.Attribute.Padding.Type: paddings = .init()

                case is Style.Attribute.Font.Type: fonts = .init()

                case is Style.Attribute.Icon.Type: icons = .init()

                // Referenced by Composition and Accent (key path refs, not resolved values).
                case is Style.Attribute.Surface.Type: surfaces = .init()

                // References Surface (key path refs, not resolved values).
                case is Style.Attribute.Composition.Type: compositions = .init()

                // Surface values can be resolved from Accent data via `builderWrapper`,
                // so changing Accent may stale cached Surface values.
                case is Style.Attribute.Accent.Type:
                    accents = .init()
                    surfaces = .init()

                case is Style.Attribute.Shape.Type: shapes = .init()

                default: fatalError("Cache is not setup properly.")

            }
        }

    }


    // MARK: - AttributeTypeCache

    /// Per-attribute cache that maps each `ValueBuilderKeyPath` to a context-specific value cache.
    ///
    /// Used by `CacheContainer` to store resolved values for a single attribute type (e.g. `Number`, `Surface`).
    /// Each key path gets its own ``ValueForContextCache`` so the same attribute can hold different resolved values for different contexts.
    package class AttributeTypeCache<Attribute: StyleAttribute> {

        private var content: [Attribute.ValueBuilderKeyPath: ValueForContextCache<Attribute.Value>] = [:]
        package var keys: [Attribute.ValueBuilderKeyPath] { Array(content.keys) }

        package func getValueCache(for keyPath: Attribute.ValueBuilderKeyPath) -> ValueForContextCache<Attribute.Value>? {
            return content[keyPath]
        }

        package func getValue(for keyPath: Attribute.ValueBuilderKeyPath, in context: Style.Context) -> Attribute.Value? {

            if let cache = content[keyPath] {
                return cache.getValue(for: context)
            }

            return nil
        }

        func setValue(_ value: Attribute.Value, for keyPath: Attribute.ValueBuilderKeyPath, in context: Style.Context) {

            if let cache = content[keyPath] {
                cache.setValue(value, for: context)
            } else {
                let cache: ValueForContextCache<Attribute.Value> = .init()
                cache.setValue(value, for: context)
                content[keyPath] = cache
            }

        }

    }


    // MARK: - ValueForContextCache

    /// Context-keyed cache that maps a ``Style/Context`` to a single resolved value.
    ///
    /// Used by ``AttributeTypeCache`` to store the resolved value for one key path across different contexts.
    /// This allows the same attribute key path to cache distinct results when the context varies (e.g. different scale factors).
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


// MARK: - Style + Cache

extension Style {


    // MARK: Get & Set

    internal func getValueFromCache<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath, in context: Style.Context) -> Attribute.Value? {
        guard let cache: AttributeTypeCache<Attribute> = cacheContainer.getCache() else { return nil }

        return cache.getValue(for: keyPath, in: context)
    }

    internal func setValueInCache<Attribute: StyleAttribute>(_ value: Attribute.Value, for keyPath: Attribute.ValueBuilderKeyPath, in context: Style.Context) {
        guard let cache: AttributeTypeCache<Attribute> = cacheContainer.getCache() else { return }

        cache.setValue(value, for: keyPath, in: context)
    }


    // MARK: Debug

    /// For debug purposes.
    package func cachedKeyPaths<Attribute: StyleAttribute>(for: Attribute.Type) -> [Attribute.ValueBuilderKeyPath] {
        guard
            let cache: AttributeTypeCache<Attribute> = cacheContainer.getCache()
        else { return [] }

        return cache.keys
    }

    /// For debug purposes.
    package func cachedContexts<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath) -> [Style.Context] {
        guard
            let cache: AttributeTypeCache<Attribute> = cacheContainer.getCache(),
            let valueCache = cache.getValueCache(for: keyPath)
        else { return [] }

        return valueCache.keys
    }

    /// For debug purposes.
    package func cachedValue<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath, in context: Style.Context) -> Attribute.Value? {
        guard
            let cache: AttributeTypeCache<Attribute> = cacheContainer.getCache(),
            let valueCache = cache.getValueCache(for: keyPath)
        else { return nil }

        return valueCache.getValue(for: context)
    }

}
