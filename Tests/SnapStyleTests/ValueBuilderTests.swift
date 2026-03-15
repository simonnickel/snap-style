//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
@testable import SnapStyleBase

/// Tests for `Style.ValueBuilder.value(in:)` — resolves values from `.base`, `.builder`,
/// and `.builderWrapper` cases.
struct ValueBuilderTests {

    
    // MARK: - Helpers

    private func makeContextWrapper(context: Style.Context = .any) -> Style.ContextWrapper {
        Style.ContextWrapper(definition: Style(), context: context)
    }


    // MARK: - .base

    @Test("base returns value when no builder is set")
    func baseWithValueNoBuilder() {
        let builder: Style.ValueBuilder<String> = .base("hello", builder: nil)

        let result = builder.value(in: makeContextWrapper())
        #expect(result == "hello")
    }

    @Test("base returns value when context is nil and no builder is set")
    func baseWithValueNoBuilderNilContext() {
        let builder: Style.ValueBuilder<String> = .base("hello", builder: nil)

        let result = builder.value(in: nil)
        #expect(result == "hello")
    }

    @Test("base with nil value and no builder returns nil")
    func baseWithNilValueNoBuilder() {
        let builder: Style.ValueBuilder<String> = .base(nil, builder: nil)

        let result = builder.value(in: makeContextWrapper())
        #expect(result == nil)
    }

    @Test("base builder takes priority over base value")
    func baseBuilderOverridesValue() {
        let builder: Style.ValueBuilder<String> = .base("fallback") { _ in
            "from-builder"
        }

        let result = builder.value(in: makeContextWrapper())
        #expect(result == "from-builder")
    }

    @Test("base falls back to value when builder returns nil")
    func baseBuilderReturnsNilFallsBack() {
        let builder: Style.ValueBuilder<String> = .base("fallback") { _ in
            nil
        }

        let result = builder.value(in: makeContextWrapper())
        #expect(result == "fallback")
    }

    @Test("base ignores builder when context is nil")
    func baseIgnoresBuilderWhenContextNil() {
        let builder: Style.ValueBuilder<String> = .base("fallback") { _ in
            "from-builder"
        }

        let result = builder.value(in: nil)
        #expect(result == "fallback")
    }


    // MARK: - .builder

    @Test("builder returns closure result")
    func builderReturnsValue() {
        let builder: Style.ValueBuilder<String> = .builder { _ in
            "built"
        }

        let result = builder.value(in: makeContextWrapper())
        #expect(result == "built")
    }

    @Test("builder returns nil when context is nil")
    func builderReturnsNilWithoutContext() {
        let builder: Style.ValueBuilder<String> = .builder { _ in
            "built"
        }

        let result = builder.value(in: nil)
        #expect(result == nil)
    }

    @Test("builder returns nil when closure returns nil")
    func builderClosureReturnsNil() {
        let builder: Style.ValueBuilder<String> = .builder { _ in
            nil
        }

        let result = builder.value(in: makeContextWrapper())
        #expect(result == nil)
    }

    @Test("builder initialized with nil returns nil")
    func builderNilClosure() {
        let builder: Style.ValueBuilder<String> = .builder(nil)

        let result = builder.value(in: makeContextWrapper())
        #expect(result == nil)
    }


    // MARK: - .builderWrapper

    @Test("builderWrapper returns closure result")
    func builderWrapperReturnsValue() {
        let builder: Style.ValueBuilder<String> = .builderWrapper { _ in
            "wrapped"
        }

        let result = builder.value(in: makeContextWrapper())
        #expect(result == "wrapped")
    }

    @Test("builderWrapper returns nil when context is nil")
    func builderWrapperReturnsNilWithoutContext() {
        let builder: Style.ValueBuilder<String> = .builderWrapper { _ in
            "wrapped"
        }

        let result = builder.value(in: nil)
        #expect(result == nil)
    }

    @Test("builderWrapper initialized with nil returns nil")
    func builderWrapperNilClosure() {
        let builder: Style.ValueBuilder<String> = .builderWrapper(nil)

        let result = builder.value(in: makeContextWrapper())
        #expect(result == nil)
    }


    // MARK: - Context forwarding

    @Test("builder receives the context from the wrapper")
    func builderReceivesContext() {
        let customContext = Style.Context.any
            .withAttribute(value: 2.0, for: Style.Context.scaleFactor)

        let builder: Style.ValueBuilder<Double> = .builder { context in
            context.scaleFactor
        }

        let result = builder.value(in: makeContextWrapper(context: customContext))
        #expect(result == 2.0)
    }

}
