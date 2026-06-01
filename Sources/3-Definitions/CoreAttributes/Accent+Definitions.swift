//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI


// MARK: - Fallback

// TODO: One should be enough, or one should reference the other.

extension Style.Attribute.Accent.Value.WrappedValue {
    
    public static var fallbackPrimary: Self {
        .surface(
            base: \.systemAccent,
            onAccent: \.snapWhite,
            complementary: \.systemAccentComplementary,
            contrast: \.systemAccentContrast,
            brightness: .dark
        )
    }
    
    public static var fallbackSecondary: Self {
        .surface(
            base: \.snapBlack,
            onAccent: \.snapWhite,
            complementary: \.snapGray,
            contrast: \.snapWhite,
            brightness: .dark
        )
    }
    
}

extension Style.Attribute.Accent {
    
    public var fallbackPrimary: ValueBuilder {
        .base(.value(
            .surface(
                base: \.systemAccent,
                onAccent: \.snapWhite,
                complementary: \.systemAccentComplementary,
                contrast: \.systemAccentContrast,
                brightness: .dark
            )
        ))
    }
    
    public var fallbackSecondary: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapBlack,
                onAccent: \.snapWhite,
                complementary: \.snapGray,
                contrast: \.snapWhite,
                brightness: .dark
            )
        ))
    }
    
}


// MARK: - Accent

extension Style.Attribute.Accent {
    
    
    // MARK: Generic Accents
    
    // TODO: Instead of context, everything should reference and override primary / secondary exclusively. Or only the context should be used and Accent should not be an Attribute at all.
    public var primary: ValueBuilder {
        .base(.reference(\.fallbackPrimary))
    }
    
    public var secondary: ValueBuilder {
        .base(.reference(\.fallbackSecondary))
    }
    
    public var destructive: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapRed,
                onAccent: \.snapWhite,
                complementary: \.snapOrange,
                contrast: \.snapYellow,
                brightness: .dark
            )
        ))
    }
    
}


// MARK: - Colors

extension Style.Attribute.Accent {
    
    public var blue: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapBlue,
                onAccent: \.snapWhite,
                complementary: \.snapMint,
                //            complementary: Color.blue.mix(with: .white, by: 0.2).mix(with: .purple, by: 0.5),
                contrast: \.snapYellow,
                brightness: .dark
            )
        ))
    }
    
    
    public var teal: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapTeal,
                onAccent: \.snapWhite,
                complementary: \.snapBlue,
                contrast: \.snapPurple,
                brightness: .light
            )
        ))
    }
    
    public var green: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapGreen,
                onAccent: \.snapWhite,
                complementary: \.snapMint,
                contrast: \.snapYellow,
                brightness: .light
            )
        ))
    }
    
    public var red: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapRed,
                onAccent: \.snapWhite,
                complementary: \.snapOrange,
                contrast: \.snapYellow,
                brightness: .dark
            )
        ))
    }
    
    public var orange: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapOrange,
                onAccent: \.snapWhite,
                complementary: \.snapYellow,
                contrast: \.snapRed,
                brightness: .light
            )
        ))
    }
    
    public var yellow: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapYellow,
                onAccent: \.snapBlack,
                complementary: \.snapOrange,
                contrast: \.snapRed,
                brightness: .light
            )
        ))
    }
    
    public var cyan: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapCyan,
                onAccent: \.snapWhite,
                complementary: \.snapGreen,
                contrast: \.snapYellow,
                brightness: .light
            )
        ))
    }
    
    public var mint: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapMint,
                onAccent: \.snapWhite,
                complementary: \.snapGreen,
                contrast: \.snapYellow,
                brightness: .light
            )
        ))
    }
    
    public var indigo: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapIndigo,
                onAccent: \.snapWhite,
                complementary: \.snapBlue,
                contrast: \.snapGreen,
                brightness: .dark
            )
        ))
    }
    
    public var purple: ValueBuilder {
        .base(.value(
            .surface(
                base: \.snapPurple,
                onAccent: \.snapWhite,
                complementary: \.snapBlue,
                contrast: \.snapYellow,
                brightness: .dark
            )
        ))
    }
    
    // TODO: Was this the better idea?
//    public static func builder(with color: Color) -> ValueBuilder {
//        .builder({ context in
//            .value(
//                .surface(
//                    base: \.snapTeal,
//                    onAccent: \.snapWhite,
//                    complementary: \.snapBlue,
//                    contrast: \.snapPurple,
//                    brightness: .light
//                )
//            )
//        })
//    }
}
