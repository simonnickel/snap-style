//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// A container to hold the configured `ValueBuilder` for all `Attributes`.
    /// It is a struct to easliy be copied when definitions branch off in the view hierarchy.
    internal struct BuilderContainer: Copyable {

        internal var numbers: [Attribute.Number.ValueBuilderKeyPath: [Attribute.Number.ValueBuilder]] = [:]
        internal var paddings: [Attribute.Padding.ValueBuilderKeyPath: [Attribute.Padding.ValueBuilder]] = [:]
        internal var fonts: [Attribute.Font.ValueBuilderKeyPath: [Attribute.Font.ValueBuilder]] = [:]
        internal var icons: [Attribute.Icon.ValueBuilderKeyPath: [Attribute.Icon.ValueBuilder]] = [:]
        internal var surfaces: [Attribute.Surface.ValueBuilderKeyPath: [Attribute.Surface.ValueBuilder]] = [:]
        internal var compositions: [Attribute.Composition.ValueBuilderKeyPath: [Attribute.Composition.ValueBuilder]] = [:]
        internal var accents: [Attribute.Accent.ValueBuilderKeyPath: [Attribute.Accent.ValueBuilder]] = [:]
        internal var shapes: [Attribute.Shape.ValueBuilderKeyPath: [Attribute.Shape.ValueBuilder]] = [:]


        // MARK: Get

        internal func builder<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath) -> [Attribute.ValueBuilder] {

            switch keyPath {

                case let keyPath as KeyPath<Style.Attribute.Number, Style.Attribute.Number.ValueBuilder>:
                    if let builders = numbers[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }
                
                case let keyPath as KeyPath<Style.Attribute.Padding, Style.Attribute.Padding.ValueBuilder>:
                    if let builders = paddings[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Style.Attribute.Font, Style.Attribute.Font.ValueBuilder>:
                    if let builders = fonts[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Style.Attribute.Icon, Style.Attribute.Icon.ValueBuilder>:
                    if let builders = icons[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Style.Attribute.Surface, Style.Attribute.Surface.ValueBuilder>:
                    if let builders = surfaces[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Style.Attribute.Composition, Style.Attribute.Composition.ValueBuilder>:
                    if let builders = compositions[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }
                    
                case let keyPath as KeyPath<Style.Attribute.Accent, Style.Attribute.Accent.ValueBuilder>:
                    if let builders = accents[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                case let keyPath as KeyPath<Style.Attribute.Shape, Style.Attribute.Shape.ValueBuilder>:
                    if let builders = shapes[keyPath] as? [Attribute.ValueBuilder] {
                        return builders
                    }

                default: fatalError("Not defined for \(Attribute.self)")

            }

            return []
        }

    }


    // MARK: Append

    internal func appended(numbers: [Attribute.Number.ValueBuilderKeyPath: Attribute.Number.ValueBuilder]) -> Self {
        appended(numbers, at: \.numbers)
    }
    
    internal func appended(paddings: [Attribute.Padding.ValueBuilderKeyPath: Attribute.Padding.ValueBuilder]) -> Self {
        appended(paddings, at: \.paddings)
    }

    internal func appended(fonts: [Attribute.Font.ValueBuilderKeyPath: Attribute.Font.ValueBuilder]) -> Self {
        appended(fonts, at: \.fonts)
    }

    internal func appended(icons: [Attribute.Icon.ValueBuilderKeyPath: Attribute.Icon.ValueBuilder]) -> Self {
        appended(icons, at: \.icons)
    }

    internal func appended(surfaces: [Attribute.Surface.ValueBuilderKeyPath: Attribute.Surface.ValueBuilder]) -> Self {
        appended(surfaces, at: \.surfaces)
    }

    internal func appended(compositions: [Attribute.Composition.ValueBuilderKeyPath: Attribute.Composition.ValueBuilder]) -> Self {
        appended(compositions, at: \.compositions)
    }

    internal func appended(accents: [Attribute.Accent.ValueBuilderKeyPath: Attribute.Accent.ValueBuilder]) -> Self {
        appended(accents, at: \.accents)
    }

    internal func appended(shapes: [Attribute.Shape.ValueBuilderKeyPath: Attribute.Shape.ValueBuilder]) -> Self {
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
