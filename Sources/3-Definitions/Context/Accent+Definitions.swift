//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension Style.Context.Accent {

// MARK: - Fallback

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


// MARK: - Accent

// TODO: Where should this be?

extension Style.Context.Accent {
    
    
    // MARK: - Generic Accents
    
    public var destructive: Self {
        .surface(
            base: \.snapRed,
            onAccent: \.snapWhite,
            complementary: \.snapOrange,
            contrast: \.snapYellow,
            brightness: .dark
        )
    }


    // MARK: - Colors
    
    //    public func builder(with color: Color) -> Self {
    //        .surface(
    //            base: \.snapTeal,
    //            onAccent: \.snapWhite,
    //            complementary: \.snapBlue,
    //            contrast: \.snapPurple,
    //            brightness: .light
    //        )
    //    }
    
    public static var blue: Self {
        .surface(
            base: \.snapBlue,
            onAccent: \.snapWhite,
            complementary: \.snapMint,
            //            complementary: Color.blue.mix(with: .white, by: 0.2).mix(with: .purple, by: 0.5),
            contrast: \.snapYellow,
            brightness: .dark
        )
    }
    
    
    public static var teal: Self {
        .surface(
            base: \.snapTeal,
            onAccent: \.snapWhite,
            complementary: \.snapBlue,
            contrast: \.snapPurple,
            brightness: .light
        )
    }
    
    public static var green: Self {
        .surface(
            base: \.snapGreen,
            onAccent: \.snapWhite,
            complementary: \.snapMint,
            contrast: \.snapYellow,
            brightness: .light
        )
    }
    
    public static var red: Self {
        .surface(
            base: \.snapRed,
            onAccent: \.snapWhite,
            complementary: \.snapOrange,
            contrast: \.snapYellow,
            brightness: .dark
        )
    }
    
    public static var orange: Self {
        .surface(
            base: \.snapOrange,
            onAccent: \.snapWhite,
            complementary: \.snapYellow,
            contrast: \.snapRed,
            brightness: .light
        )
    }
    
    public static var yellow: Self {
        .surface(
            base: \.snapYellow,
            onAccent: \.snapBlack,
            complementary: \.snapOrange,
            contrast: \.snapRed,
            brightness: .light
        )
    }
    
    public static var cyan: Self {
        .surface(
            base: \.snapCyan,
            onAccent: \.snapWhite,
            complementary: \.snapGreen,
            contrast: \.snapYellow,
            brightness: .light
        )
    }
    
    public static var mint: Self {
        .surface(
            base: \.snapMint,
            onAccent: \.snapWhite,
            complementary: \.snapGreen,
            contrast: \.snapYellow,
            brightness: .light
        )
    }
    
    public static var indigo: Self {
        .surface(
            base: \.snapIndigo,
            onAccent: \.snapWhite,
            complementary: \.snapBlue,
            contrast: \.snapGreen,
            brightness: .dark
        )
    }
    
    public static var purple: Self {
        .surface(
            base: \.snapPurple,
            onAccent: \.snapWhite,
            complementary: \.snapBlue,
            contrast: \.snapYellow,
            brightness: .dark
        )
    }
    
}
