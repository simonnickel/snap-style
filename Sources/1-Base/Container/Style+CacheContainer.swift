//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// A Container to bundle references to `StyleAttribute` specific caches.
    /// It is a struct to easliy be copied when definitions branch off in the view hierarchy.
    internal struct CacheContainer {

        // References to `StyleAttribute` specific caches.
        internal var numbers: AttributeTypeCache<Attributes.Number> = .init()
        internal var fonts: AttributeTypeCache<Attributes.Font> = .init()
        internal var icons: AttributeTypeCache<Attributes.Icon> = .init()
        internal var surfaces: AttributeTypeCache<Attributes.Surface> = .init()
        internal var compositions: AttributeTypeCache<Attributes.Composition> = .init()
        internal var accents: AttributeTypeCache<Attributes.Accent> = .init()
        internal var shapes: AttributeTypeCache<Attributes.Shape> = .init()

        internal func getCache<Attribute: StyleAttribute>() -> AttributeTypeCache<Attribute>? {
            switch Attribute.self {

                case let key as Attributes.Number.Type: return numbers as? AttributeTypeCache<Attribute>

                case let key as Attributes.Font.Type: return fonts as? AttributeTypeCache<Attribute>

                case let key as Attributes.Icon.Type: return icons as? AttributeTypeCache<Attribute>

                case let key as Attributes.Surface.Type: return surfaces as? AttributeTypeCache<Attribute>

                case let key as Attributes.Composition.Type: return compositions as? AttributeTypeCache<Attribute>
                    
                case let key as Attributes.Accent.Type: return accents as? AttributeTypeCache<Attribute>

                case let key as Attributes.Shape.Type: return shapes as? AttributeTypeCache<Attribute>

                default: fatalError("Cache is not setup properly.")

            }
        }

        /// Creates a new cache, the old cache will still be in use for a different style definition.
        internal mutating func resetCache<Attribute: StyleAttribute>(for: Attribute.Type) {
            switch Attribute.self {

                case let key as Attributes.Number.Type: numbers = .init()

                case let key as Attributes.Font.Type: fonts = .init()

                case let key as Attributes.Icon.Type: icons = .init()

                case let key as Attributes.Surface.Type:
                    compositions = .init()
                    surfaces = .init()

                case let key as Attributes.Composition.Type:
                    compositions = .init()
                    surfaces = .init()
                    
                case let key as Attributes.Accent.Type:
                    accents = .init()
                    compositions = .init()
                    surfaces = .init()

                case let key as Attributes.Shape.Type: shapes = .init()

                default: fatalError("Cache is not setup properly.")

            }
        }

    }


    // MARK: - AttributeTypeCache

    package class AttributeTypeCache<Attribute: StyleAttribute> {

        private var content: [Attribute.ValueBuilderKeyPath: ValueForContextCache<Attribute.Value>] = [:]
        package var keys: [Attribute.ValueBuilderKeyPath] { Array(content.keys) }

        package func getValueCache(for keyPath: KeyPath<Attribute, Attribute.ValueBuilder>) -> ValueForContextCache<Attribute.Value>? {
            return content[keyPath]
        }

        package func getValue(for keyPath: KeyPath<Attribute, Attribute.ValueBuilder>, in context: Style.Context) -> Attribute.Value? {

            if let cache = content[keyPath] {
                return cache.getValue(for: context)
            }

            return nil
        }

        func setValue(_ value: Attribute.Value, for keyPath: KeyPath<Attribute, Attribute.ValueBuilder>, in context: Style.Context) {

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

    internal func getValueFromCache<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath, in context: Style.Context) -> Attribute.Value? {
        guard let cache: AttributeTypeCache<Attribute> = cacheContainer.getCache() else { return nil }

        return cache.getValue(for: keyPath, in: context)
    }

    internal func setValueInCache<Attribute: StyleAttribute>(_ value: Attribute.Value, for keyPath: KeyPath<Attribute, Attribute.ValueBuilder>, in context: Style.Context) {
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
