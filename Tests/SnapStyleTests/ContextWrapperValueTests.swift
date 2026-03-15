//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
@testable import SnapStyleBase

/// Tests for `ContextWrapper.value(for:with:)` — the full value resolution pipeline
/// including cache, builder iteration, reference resolution, and default fallback.
struct ContextWrapperValueTests {

    // MARK: - Helpers

    private let baseValue = Style.Attribute.Number.testBaseValue

    private func makeContextWrapper(
        definition: Style = Style(),
        context: Style.Context = .any
    ) -> Style.ContextWrapper {
        Style.ContextWrapper(definition: definition, context: context)
    }

    /// Reference-type counter for tracking builder invocations in `@Sendable` closures.
    private final class CallCounter: @unchecked Sendable {
        var count = 0
    }


    // MARK: - Default fallback

    @Test("resolves default value when no overrides exist")
    func defaultValueFallback() {
        let wrapper = makeContextWrapper()

        #expect(wrapper.number(for: \.testNumber, scaled: false) == baseValue)
    }


    // MARK: - Override via appended builders

    @Test("appended builder takes priority over default")
    func overrideTakesPriority() {
        let overrideValue = 42.0
        let definition = Style()
            .appended(numbers: [\.testNumber: .base(.value(.scaled(overrideValue)))])

        let wrapper = makeContextWrapper(definition: definition)

        #expect(wrapper.number(for: \.testNumber, scaled: false) == overrideValue)
    }

    @Test("last appended builder wins")
    func lastBuilderWins() {
        let lastValue = 99.0
        let definition = Style()
            .appended(numbers: [\.testNumber: .base(.value(.scaled(10)))])
            .appended(numbers: [\.testNumber: .base(.value(.scaled(lastValue)))])

        let wrapper = makeContextWrapper(definition: definition)

        #expect(wrapper.number(for: \.testNumber, scaled: false) == lastValue)
    }

    @Test("nil-returning builder falls through to previous builder")
    func builderNilFallsThrough() {
        let fallbackValue = 42.0
        let definition = Style()
            .appended(numbers: [\.testNumber: .base(.value(.scaled(fallbackValue)))])
            .appended(numbers: [\.testNumber: .base(nil)])

        let wrapper = makeContextWrapper(definition: definition)

        #expect(wrapper.number(for: \.testNumber, scaled: false) == fallbackValue)
    }


    // MARK: - Reference resolution

    @Test("resolves a reference to another key path")
    func referenceResolution() {
        let wrapper = makeContextWrapper()

        #expect(wrapper.number(for: \.testReference, scaled: false) == baseValue)
    }

    @Test("resolves a chain of references")
    func chainedReferences() {
        let wrapper = makeContextWrapper()

        #expect(wrapper.number(for: \.testChainedReference, scaled: false) == baseValue)
    }


    // MARK: - Caching

    @Test("repeated call returns cached value without re-evaluating builder")
    func cacheHit() {
        let counter = CallCounter()
        let builtValue = 77.0
        let definition = Style()
            .appended(numbers: [\.testNumber: .builder { _ in
                counter.count += 1
                return .value(.scaled(builtValue))
            }])

        let wrapper = makeContextWrapper(definition: definition)

        let first = wrapper.number(for: \.testNumber, scaled: false)
        let second = wrapper.number(for: \.testNumber, scaled: false)

        #expect(first == builtValue)
        #expect(second == builtValue)
        #expect(counter.count == 1)
    }

    @Test("appending a new builder invalidates cache")
    func cacheReset() {
        let counter = CallCounter()
        var definition = Style()
            .appended(numbers: [\.testNumber: .builder { _ in
                counter.count += 1
                return .value(.scaled(77))
            }])

        let wrapper1 = makeContextWrapper(definition: definition)
        let _ = wrapper1.number(for: \.testNumber, scaled: false)
        #expect(counter.count == 1)

        definition = definition
            .appended(numbers: [\.testReference: .base(.value(.scaled(0)))])

        let wrapper2 = makeContextWrapper(definition: definition)
        let _ = wrapper2.number(for: \.testNumber, scaled: false)
        #expect(counter.count == 2)
    }


    // MARK: - Context-dependent builders

    @Test("builder varies result based on context")
    func contextDependentBuilder() {
        let normalValue = 10.0
        let scaledValue = 20.0
        let definition = Style()
            .appended(numbers: [\.testNumber: .builder { context in
                if context.scaleFactor > 1 {
                    return .value(.scaled(scaledValue))
                } else {
                    return .value(.scaled(normalValue))
                }
            }])

        let normalWrapper = makeContextWrapper(definition: definition)
        let scaledWrapper = makeContextWrapper(
            definition: definition,
            context: .any.withAttribute(value: 2.0, for: Style.Context.scaleFactor)
        )

        #expect(normalWrapper.number(for: \.testNumber, scaled: false) == normalValue)
        #expect(scaledWrapper.number(for: \.testNumber, scaled: false) == scaledValue)
    }

}
