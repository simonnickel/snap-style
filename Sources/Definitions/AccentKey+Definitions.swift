//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension SnapStyle.AccentKey {
    
    
    // MARK: - Generic Accents
    
    public var primary: ValueBuilder {
        .base(.definition(.value(
            SnapStyle.Accent(
                base: Color.accentColor,
                onAccent: Color.white,
                complementary: Color.accentColor.mix(with: .white, by: 0.2),
                contrast: Color.accentColor.mix(with: .black, by: 0.2),
                brightness: .dark
            )
        )))
    }
    
    public var secondary: ValueBuilder {
        .base(.definition(.value(
            SnapStyle.Accent(
                base: Color.black,
                onAccent: Color.white,
                complementary: Color.gray,
                contrast: Color.white,
                brightness: .dark
            )
        )))
    }
    
}

extension SnapStyle.Accent {
    
    public static var blue: Self {
        Self(
            base: Color.blue,
            onAccent: Color.white,
            complementary: Color.mint,
//            complementary: Color.blue.mix(with: .white, by: 0.2).mix(with: .purple, by: 0.5),
            contrast: Color.yellow,
            brightness: .dark
        )
    }
    
    public static var teal: Self {
        Self(
            base: Color.teal,
            onAccent: Color.white,
            complementary: Color.blue,
            contrast: Color.purple,
            brightness: .light
        )
    }
    
    public static var green: Self {
        Self(
            base: Color.green,
            onAccent: Color.white,
            complementary: Color.mint,
            contrast: Color.yellow,
            brightness: .light
        )
    }
    
    public static var red: Self {
        Self(
            base: Color.red,
            onAccent: Color.white,
            complementary: Color.orange,
            contrast: Color.yellow,
            brightness: .dark
        )
    }
    
    public static var orange: Self {
        Self(
            base: Color.orange,
            onAccent: Color.white,
            complementary: Color.yellow,
            contrast: Color.red,
            brightness: .light
        )
    }
    
    public static var yellow: Self {
        Self(
            base: Color.yellow,
            onAccent: Color.black,
            complementary: Color.orange,
            contrast: Color.red,
            brightness: .light
        )
    }
    
    public static var cyan: Self {
        Self(
            base: Color.cyan,
            onAccent: Color.white,
            complementary: Color.green,
            contrast: Color.yellow,
            brightness: .light
        )
    }
    
    public static var mint: Self {
        Self(
            base: Color.mint,
            onAccent: Color.white,
            complementary: Color.green,
            contrast: Color.yellow,
            brightness: .light
        )
    }
    
    public static var indigo: Self {
        Self(
            base: Color.indigo,
            onAccent: Color.white,
            complementary: Color.blue,
            contrast: Color.green,
            brightness: .dark
        )
    }
    
    public static var purple: Self {
        Self(
            base: Color.purple,
            onAccent: Color.white,
            complementary: Color.blue,
            contrast: Color.yellow,
            brightness: .dark
        )
    }
    
}
