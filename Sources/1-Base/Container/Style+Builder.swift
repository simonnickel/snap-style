//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    internal struct BuilderContainer: Copyable {

        internal var numbers: [Attributes.Number.ValueBuilderKeyPath: [Attributes.Number.ValueBuilder]] = [:]
        internal var fonts: [Attributes.Font.ValueBuilderKeyPath: [Attributes.Font.ValueBuilder]] = [:]
        internal var icons: [Attributes.Icon.ValueBuilderKeyPath: [Attributes.Icon.ValueBuilder]] = [:]
        internal var surfaces: [Attributes.Surface.ValueBuilderKeyPath: [Attributes.Surface.ValueBuilder]] = [:]
        internal var compositions: [Attributes.Composition.ValueBuilderKeyPath: [Attributes.Composition.ValueBuilder]] = [:]
        internal var accents: [Attributes.Accent.ValueBuilderKeyPath: [Attributes.Accent.ValueBuilder]] = [:]
        internal var shapes: [Attributes.Shape.ValueBuilderKeyPath: [Attributes.Shape.ValueBuilder]] = [:]


        // MARK: Get

        internal func builder<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath) -> [Attribute.ValueBuilder] {

            switch keyPath {

                case let keyPath as KeyPath<Attributes.Number, Attributes.Number.ValueBuilder>:
                    if let builders = numbers[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Attributes.Font, Attributes.Font.ValueBuilder>:
                    if let builders = fonts[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Attributes.Icon, Attributes.Icon.ValueBuilder>:
                    if let builders = icons[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Attributes.Surface, Attributes.Surface.ValueBuilder>:
                    if let builders = surfaces[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Attributes.Composition, Attributes.Composition.ValueBuilder>:
                    if let builders = compositions[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }
                    
                case let keyPath as KeyPath<Attributes.Accent, Attributes.Accent.ValueBuilder>:
                    if let builders = accents[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Attributes.Shape, Attributes.Shape.ValueBuilder>:
                    if let builders = shapes[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                default: fatalError("Not defined for \(Attribute.self)")

            }

            return []
        }

    }


    // MARK: Append

    internal func appended(numbers: [Attributes.Number.ValueBuilderKeyPath: Attributes.Number.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }

    internal func appended(fonts: [Attributes.Font.ValueBuilderKeyPath: Attributes.Font.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }

    internal func appended(icons: [Attributes.Icon.ValueBuilderKeyPath: Attributes.Icon.ValueBuilder]) -> Self {
        appended(icons, at: \.icons)
    }

    internal func appended(surfaces: [Attributes.Surface.ValueBuilderKeyPath: Attributes.Surface.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }

    internal func appended(compositions: [Attributes.Composition.ValueBuilderKeyPath: Attributes.Composition.ValueBuilder]) -> Self {
        appended(compositions, at: \.compositions)
    }

    internal func appended(accents: [Attributes.Accent.ValueBuilderKeyPath: Attributes.Accent.ValueBuilder]) -> Self {
        appended(accents, at: \.accents)
    }

    internal func appended(shapes: [Attributes.Shape.ValueBuilderKeyPath: Attributes.Shape.ValueBuilder]) -> Self {
        appended(shapes, at: \.shapes)
    }

    private func appended<Attribute: StyleAttribute>(_ keyPaths: [Attribute.ValueBuilderKeyPath: Attribute.ValueBuilder], at destination: WritableKeyPath<Style.BuilderContainer, [Attribute.ValueBuilderKeyPath: [Attribute.ValueBuilder]]>) -> Self {

        var copy = self
        copy.cacheContainer.resetCache(for: Attribute.self)

        for (keyPath, valueBuilder) in keyPaths {

            var builders = self.builderContainer[keyPath: destination][keyPath] ?? []
            builders.append(valueBuilder)
            copy.builderContainer[keyPath: destination][keyPath] = builders

        }

        return copy
    }
}
