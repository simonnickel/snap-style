//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    internal struct BuilderContainer: Copyable {

        internal var numbers: [Keys.Number.ValueBuilderKeyPath: [Keys.Number.ValueBuilder]] = [:]
        internal var fonts: [Keys.Font.ValueBuilderKeyPath: [Keys.Font.ValueBuilder]] = [:]
        internal var icons: [Keys.Icon.ValueBuilderKeyPath: [Keys.Icon.ValueBuilder]] = [:]
        internal var surfaces: [Keys.Surface.ValueBuilderKeyPath: [Keys.Surface.ValueBuilder]] = [:]
        internal var compositions: [Keys.Composition.ValueBuilderKeyPath: [Keys.Composition.ValueBuilder]] = [:]
        internal var accents: [Keys.Accent.ValueBuilderKeyPath: [Keys.Accent.ValueBuilder]] = [:]
        internal var shapes: [Keys.Shape.ValueBuilderKeyPath: [Keys.Shape.ValueBuilder]] = [:]


        // MARK: Get

        internal func builder<Key: StyleKey>(for keyPath: Key.ValueBuilderKeyPath) -> [Key.ValueBuilder] {

            switch keyPath {

                case let keyPath as KeyPath<Keys.Number, Keys.Number.ValueBuilder>:
                    if let builders = numbers[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.Font, Keys.Font.ValueBuilder>:
                    if let builders = fonts[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.Icon, Keys.Icon.ValueBuilder>:
                    if let builders = icons[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.Surface, Keys.Surface.ValueBuilder>:
                    if let builders = surfaces[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.Composition, Keys.Composition.ValueBuilder>:
                    if let builders = compositions[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }
                    
                case let keyPath as KeyPath<Keys.Accent, Keys.Accent.ValueBuilder>:
                    if let builders = accents[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Keys.Shape, Keys.Shape.ValueBuilder>:
                    if let builders = shapes[keyPath] as? [Key.ValueBuilder] {
                        return builders
                    }

                default: fatalError("Not defined for \(Key.self)")

            }

            return []
        }

    }


    // MARK: Append

    internal func appended(numbers: [Keys.Number.ValueBuilderKeyPath: Keys.Number.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }

    internal func appended(fonts: [Keys.Font.ValueBuilderKeyPath: Keys.Font.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }

    internal func appended(icons: [Keys.Icon.ValueBuilderKeyPath: Keys.Icon.ValueBuilder]) -> Self {
        appended(icons, at: \.icons)
    }

    internal func appended(surfaces: [Keys.Surface.ValueBuilderKeyPath: Keys.Surface.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }

    internal func appended(compositions: [Keys.Composition.ValueBuilderKeyPath: Keys.Composition.ValueBuilder]) -> Self {
        appended(compositions, at: \.compositions)
    }

    internal func appended(accents: [Keys.Accent.ValueBuilderKeyPath: Keys.Accent.ValueBuilder]) -> Self {
        appended(accents, at: \.accents)
    }

    internal func appended(shapes: [Keys.Shape.ValueBuilderKeyPath: Keys.Shape.ValueBuilder]) -> Self {
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
