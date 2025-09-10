//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension Style.Keys.AccentKey.Value.WrappedValue {

    public static var fallbackPrimary: Self {
        Self(
            base: \.systemAccent,
            onAccent: \.snapWhite,
            complementary: \.systemAccentComplementary,
            contrast: \.systemAccentContrast,
            brightness: .dark
        )
    }
    
    public static var fallbackSecondary: Self {
        Self(
            base: \.snapBlack,
            onAccent: \.snapWhite,
            complementary: \.snapGray,
            contrast: \.snapWhite,
            brightness: .dark
        )
    }

}


// MARK: - AccentKey

extension Style.Keys.AccentKey {
    
    
    // MARK: Generic Accents
    
    public var primary: ValueBuilder {
        .base(.definition(.value(
            .fallbackPrimary
        )))
    }
    
    public var secondary: ValueBuilder {
        .base(.definition(.value(
            .fallbackSecondary
        )))
    }
    
    public var destructive: ValueBuilder {
        .base(.definition(.value(
            .init(
                base: \.snapRed,
                onAccent: \.snapWhite,
                complementary: \.snapOrange,
                contrast: \.snapYellow,
                brightness: .dark
            )
        )))
    }
    
}


// MARK: - Colors

extension Style.Keys.AccentKey.Value.WrappedValue {
    
    public static var blue: Self {
        Self(
            base: \.snapBlue,
            onAccent: \.snapWhite,
            complementary: \.snapMint,
//            complementary: Color.blue.mix(with: .white, by: 0.2).mix(with: .purple, by: 0.5),
            contrast: \.snapYellow,
            brightness: .dark
        )
    }
    
    public static var teal: Self {
        Self(
            base: \.snapTeal,
            onAccent: \.snapWhite,
            complementary: \.snapBlue,
            contrast: \.snapPurple,
            brightness: .light
        )
    }
    
    public static var green: Self {
        Self(
            base: \.snapGreen,
            onAccent: \.snapWhite,
            complementary: \.snapMint,
            contrast: \.snapYellow,
            brightness: .light
        )
    }
    
    public static var red: Self {
        Self(
            base: \.snapRed,
            onAccent: \.snapWhite,
            complementary: \.snapOrange,
            contrast: \.snapYellow,
            brightness: .dark
        )
    }
    
    public static var orange: Self {
        Self(
            base: \.snapOrange,
            onAccent: \.snapWhite,
            complementary: \.snapYellow,
            contrast: \.snapRed,
            brightness: .light
        )
    }
    
    public static var yellow: Self {
        Self(
            base: \.snapYellow,
            onAccent: \.snapBlack,
            complementary: \.snapOrange,
            contrast: \.snapRed,
            brightness: .light
        )
    }
    
    public static var cyan: Self {
        Self(
            base: \.snapCyan,
            onAccent: \.snapWhite,
            complementary: \.snapGreen,
            contrast: \.snapYellow,
            brightness: .light
        )
    }
    
    public static var mint: Self {
        Self(
            base: \.snapMint,
            onAccent: \.snapWhite,
            complementary: \.snapGreen,
            contrast: \.snapYellow,
            brightness: .light
        )
    }
    
    public static var indigo: Self {
        Self(
            base: \.snapIndigo,
            onAccent: \.snapWhite,
            complementary: \.snapBlue,
            contrast: \.snapGreen,
            brightness: .dark
        )
    }
    
    public static var purple: Self {
        Self(
            base: \.snapPurple,
            onAccent: \.snapWhite,
            complementary: \.snapBlue,
            contrast: \.snapYellow,
            brightness: .dark
        )
    }
    
}
