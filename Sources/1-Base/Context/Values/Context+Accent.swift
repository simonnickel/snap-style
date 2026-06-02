//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension Style.Context {
    
    public var accentPrimary: Style.Context.Accent? { getValue(for: Self.accentPrimary) }

    public static var accentPrimary: Attribute<String, Style.Context.Accent> { .init(key: "accentPrimary", valueDefault: nil) }
    
    public var accentSecondary: Style.Context.Accent? { getValue(for: Self.accentSecondary) }

    public static var accentSecondary: Attribute<String, Style.Context.Accent> { .init(key: "accentSecondary", valueDefault: nil) }
    
    
    // MARK: - Accent
    
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
