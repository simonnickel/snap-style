//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
import SwiftUI
@testable import SnapStyleBase
import SnapStyleDefinitions

private typealias NumberKeyPath = Style.Attribute.Number.ValueBuilderKeyPath

/// Tests for `ContextWrapper.number(for:scaled:)` — the number scaling logic
/// that combines `scaleFactor` and `scaleDynamicType`.
struct NumberScalingTests {

    // MARK: - Helpers

    private let baseValue = Style.Attribute.Number.testBaseValue

    private func makeContextWrapper(
        definition: Style = Style(),
        scaleFactor: Double = 1.0,
        scaleDynamicType: Double = 1.0
    ) -> Style.ContextWrapper {
        let context = Style.Context.any
            .withAttribute(value: scaleFactor, for: Style.Context.scaleFactor)
            .withAttribute(value: scaleDynamicType, for: Style.Context.scaleDynamicType)

        return Style.ContextWrapper(definition: definition, context: context)
    }


    // MARK: - Default scaling

    @Test("default scale factors return raw value")
    func defaultScaleFactors() {
        let wrapper = makeContextWrapper()
        #expect(wrapper.number(for: \.testNumber) == baseValue)
    }

    @Test("nil keyPath returns nil")
    func nilKeyPath() {
        let wrapper = makeContextWrapper()
        let keyPath: NumberKeyPath? = nil
        #expect(wrapper.number(for: keyPath) == nil)
    }


    // MARK: - Scale factors

    @Test("scales by scaleFactor")
    func scalesWithScaleFactor() {
        let factor = 2.0
        let wrapper = makeContextWrapper(scaleFactor: factor)
        #expect(wrapper.number(for: \.testNumber) == baseValue * factor)
    }

    @Test("scales by scaleDynamicType")
    func scalesWithDynamicType() {
        let dynamicType = 1.5
        let wrapper = makeContextWrapper(scaleDynamicType: dynamicType)
        #expect(wrapper.number(for: \.testNumber) == baseValue * dynamicType)
    }

    @Test("scales by both factors combined")
    func scalesBothFactors() {
        let factor = 2.0
        let dynamicType = 1.5
        let wrapper = makeContextWrapper(scaleFactor: factor, scaleDynamicType: dynamicType)
        #expect(wrapper.number(for: \.testNumber) == baseValue * factor * dynamicType)
    }


    // MARK: - Unscaled

    @Test("scaled=false ignores both factors")
    func unscaledIgnoresFactors() {
        let wrapper = makeContextWrapper(scaleFactor: 3.0, scaleDynamicType: 2.0)
        #expect(wrapper.number(for: \.testNumber, scaled: false) == baseValue)
    }


    // MARK: - cgFloat

    @Test("cgFloat returns scaled CGFloat value")
    func cgFloatConversion() {
        let factor = 2.0
        let wrapper = makeContextWrapper(scaleFactor: factor)
        #expect(wrapper.cgFloat(for: \.testNumber) == CGFloat(baseValue * factor))
    }

    @Test("cgFloat with nil keyPath returns nil")
    func cgFloatNilKeyPath() {
        let wrapper = makeContextWrapper()
        let keyPath: NumberKeyPath? = nil
        #expect(wrapper.cgFloat(for: keyPath) == nil)
    }

    @Test("cgFloat scaled=false bypasses scaling")
    func cgFloatUnscaled() {
        let factor = 5.0
        let wrapper = makeContextWrapper(scaleFactor: factor)
        #expect(wrapper.cgFloat(for: \.testNumber, scaled: false) == CGFloat(baseValue))
    }


    // MARK: - Edge cases

    @Test("zero scale factor returns zero")
    func zeroScaleFactor() {
        let wrapper = makeContextWrapper(scaleFactor: 0.0)
        #expect(wrapper.number(for: \.testNumber) == baseValue * 0.0)
    }

    @Test("zero definition value returns zero regardless of scaling")
    func zeroDefinition() {
        let wrapper = makeContextWrapper(scaleFactor: 5.0, scaleDynamicType: 3.0)
        #expect(wrapper.number(for: \.zero) == 0.0)
    }

}
