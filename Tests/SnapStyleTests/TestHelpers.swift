//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

@testable import SnapStyleBase

extension Style.Attribute.Number {

    static var testBaseValue: Double { 10 }

    public var testNumber: ValueBuilder { .base(.value(.scaled(Self.testBaseValue))) }

    /// References `testNumber`.
    public var testReference: ValueBuilder { .base(.reference(\.testNumber)) }

    /// References `testReference`, which references `testNumber` (chained).
    public var testChainedReference: ValueBuilder { .base(.reference(\.testReference)) }

}
