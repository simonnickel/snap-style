//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.Context {
    
    /// The `Accent.Key` that is used for accents.
    public var accent: Accent.Key {
        getValue(for: Self.accent) ?? Accent.Key.default
    }
    
    public static var accent: Attribute<String, Accent.Key> { .init(key: "accent", valueDefault: Accent.Key.default) }
    
    
    // MARK: - Definitions
    
    public typealias AccentDefinitions = [Accent.Key : Accent]
    
    /// The `Accent` definitions for each`Accent.Key`.
    public var accents: AccentDefinitions {
        getValue(for: Self.accents) ?? [:]
    }
    
    public static var accents: Attribute<String, AccentDefinitions> { .init(key: "accentDefinitions", valueDefault: nil) }
    
    
    // MARK: - Convenience
    
    public func accent(for key: Accent.Key?) -> Accent? {
        if let key {
            accents[key]
        } else {
            nil
        }
    }
    
}


// MARK: - Key

extension Style.Context.Accent {
    
    public struct Key: Identifiable, Hashable, Equatable {
        
        public let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public static var `default`: Self { primary }
        public static var primary: Self { Self(id: "primary") }
        public static var secondary: Self { Self(id: "secondary") }
        public static var destructive: Self { Self(id: "destructive") }
        
    }
}

    
// MARK: - Accent

extension Style.Context {
    
    public enum Accent: Hashable, Equatable {
        
        public typealias WrappedValue = Self
        
        public typealias SurfaceValue = Style.Attribute.Surface.ValueBuilderKeyPath
        
        /// A set of values referencing surfaces.
        case surface(
            base: SurfaceValue,
            onAccent: SurfaceValue,
            complementary: SurfaceValue,
            contrast: SurfaceValue,
            brightness: Brightness,
        )
        
        /// A set of values with colors.
        case color(
            base: Color,
            onAccent: Color,
            complementary: Color,
            contrast: Color,
            brightness: Brightness,
        )
        
        public var wrappedValue: WrappedValue { self }
        
        public var description: String {
            "\(self)" // TODO finetuning: Proper description
        }
        
        
        // MARK: - Variant
        
        public enum Variant {
            case base, onAccent, complementary, contrast
        }
        
        public func color(of variant: Variant = .base, in context: Style.ContextWrapper) -> Color {
            return switch self {
                case .surface(let base, let onAccent, let complementary, let contrast, let brightness):
                    switch variant {
                        case .base: context.surface(for: base)?.resolvedColor ?? .clear
                        case .onAccent: context.surface(for: onAccent)?.resolvedColor ?? .clear
                        case .complementary: context.surface(for: complementary)?.resolvedColor ?? .clear
                        case .contrast: context.surface(for: contrast)?.resolvedColor ?? .clear
                    }
                case .color(let base, let onAccent, let complementary, let contrast, let brightness):
                    switch variant {
                        case .base: base
                        case .onAccent: onAccent
                        case .complementary: complementary
                        case .contrast: contrast
                    }
            }

        }
        
        
        // MARK: - Brightness
        
        public enum Brightness {
            case light, dark
        }
        
        public var brightness: Brightness {
            switch self {
                case .surface(_, _, _, _, let brightness): brightness
                case .color(_, _, _, _, let brightness): brightness
            }
        }
    }

}
