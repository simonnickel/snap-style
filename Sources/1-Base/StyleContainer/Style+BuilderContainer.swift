//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style {

    /// A container to hold the configured `ValueBuilder` for all `Attribute` types.
    /// It is a struct to easily be copied when definitions branch off in the view hierarchy.
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

        internal func builders<Attribute: StyleAttribute>(for keyPath: Attribute.ValueBuilderKeyPath) -> [Attribute.ValueBuilder] {

            // Type-erase to Any​Key​Path, this prevents the compiler from warning "cast always fails"
            let anyKeyPath: AnyKeyPath = keyPath

            switch Attribute.self {

                case is Style.Attribute.Number.Type:
                    if let key = anyKeyPath as? Style.Attribute.Number.ValueBuilderKeyPath {
                        return numbers[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Padding.Type:
                    if let key = anyKeyPath as? Style.Attribute.Padding.ValueBuilderKeyPath {
                        return paddings[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Font.Type:
                    if let key = anyKeyPath as? Style.Attribute.Font.ValueBuilderKeyPath {
                        return fonts[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Icon.Type:
                    if let key = anyKeyPath as? Style.Attribute.Icon.ValueBuilderKeyPath {
                        return icons[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Surface.Type:
                    if let key = anyKeyPath as? Style.Attribute.Surface.ValueBuilderKeyPath {
                        return surfaces[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Composition.Type:
                    if let key = anyKeyPath as? Style.Attribute.Composition.ValueBuilderKeyPath {
                        return compositions[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Accent.Type:
                    if let key = anyKeyPath as? Style.Attribute.Accent.ValueBuilderKeyPath {
                        return accents[key] as? [Attribute.ValueBuilder] ?? []
                    }

                case is Style.Attribute.Shape.Type:
                    if let key = anyKeyPath as? Style.Attribute.Shape.ValueBuilderKeyPath {
                        return shapes[key] as? [Attribute.ValueBuilder] ?? []
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
