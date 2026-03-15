//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
import SwiftUI
@testable import SnapStyleBase

/// Tests for `Style.Context` attribute storage (`withAttribute` / `getValue`).
struct ContextTests {

    // MARK: - getValue

    @Test("getValue returns default when key is not set")
    func getValueReturnsDefault() {
        let context = Style.Context.any
        #expect(context.getValue(for: Style.Context.scaleFactor) == 1.0)
    }

    @Test("getValue returns nil when key has no default")
    func getValueReturnsNilNoDefault() {
        let context = Style.Context.any

        let attribute = Style.Context.Attribute<String, Int>(key: "nonexistent", valueDefault: nil)
        #expect(context.getValue(for: attribute) == nil)
    }

    @Test("getValue returns stored value after withAttribute")
    func getValueAfterSet() {
        let context = Style.Context.any
            .withAttribute(value: 2.5, for: Style.Context.scaleFactor)

        #expect(context.getValue(for: Style.Context.scaleFactor) == 2.5)
    }


    // MARK: - withAttribute

    @Test("withAttribute does not modify the original context")
    func withAttributeImmutability() {
        let original = Style.Context.any
        let modified = original.withAttribute(value: 3.0, for: Style.Context.scaleFactor)

        #expect(original.scaleFactor == 1.0)
        #expect(modified.scaleFactor == 3.0)
    }

    @Test("chained withAttribute calls accumulate values")
    func chainingAttributes() {
        let context = Style.Context.any
            .withAttribute(value: 2.0, for: Style.Context.scaleFactor)
            .withAttribute(value: 3, for: Style.Context.elevation)

        #expect(context.scaleFactor == 2.0)
        #expect(context.elevation == 3)
    }

    @Test("later withAttribute overrides earlier value for same key")
    func overrideSameKey() {
        let context = Style.Context.any
            .withAttribute(value: 2.0, for: Style.Context.scaleFactor)
            .withAttribute(value: 5.0, for: Style.Context.scaleFactor)

        #expect(context.scaleFactor == 5.0)
    }


    // MARK: - Equatable

    @Test("two default contexts are equal")
    func identicalContextsEqual() {
        #expect(Style.Context.any == Style.Context.any)
    }

    @Test("contexts with same attribute values are equal")
    func sameAttributesEqual() {
        let a = Style.Context.any.withAttribute(value: 2.0, for: Style.Context.scaleFactor)
        let b = Style.Context.any.withAttribute(value: 2.0, for: Style.Context.scaleFactor)
        #expect(a == b)
    }

    @Test("contexts with different attribute values are not equal")
    func differentAttributesNotEqual() {
        let a = Style.Context.any.withAttribute(value: 1.0, for: Style.Context.scaleFactor)
        let b = Style.Context.any.withAttribute(value: 2.0, for: Style.Context.scaleFactor)
        #expect(a != b)
    }

}
