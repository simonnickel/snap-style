//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
@testable import SnapStyleBase

extension Style.Attribute.Number {

    static var testBaseValue: Double { 10 }

    public var testNumber: ValueBuilder { .base(.value(.scaled(Self.testBaseValue))) }

    /// References `testNumber`.
    public var testReference: ValueBuilder { .base(.reference(\.testNumber)) }

    /// References `testReference`, which references `testNumber` (chained).
    public var testChainedReference: ValueBuilder { .base(.reference(\.testReference)) }

}

extension Style.Attribute.Surface {

    public var testSurface: ValueBuilder { .base(.value(.color(.red))) }

}


extension Style.Attribute.Composition {

    public var testComposition: ValueBuilder { .base(.value(.foreground(\.testSurface))) }

}


extension Style.Attribute.Padding {

    public var testPadding: ValueBuilder { .base(.value(.all(\.testNumber))) }

}


extension Style.Attribute.Accent {

    public var testAccent: ValueBuilder {
        .base(.value(.init(
            base: \.testSurface,
            onAccent: \.testSurface,
            complementary: \.testSurface,
            contrast: \.testSurface,
            brightness: .light
        )))
    }

}

