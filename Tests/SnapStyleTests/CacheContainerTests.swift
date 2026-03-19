//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
import SwiftUI
@testable import SnapStyleBase

/// Tests for the cache hierarchy: `ValueForContextCache`, `AttributeTypeCache`,
/// `CacheContainer.resetCache(for:)`, and `Style` cache integration.
struct CacheContainerTests {

    // MARK: - ValueForContextCache

    @Test("getValue returns nil for unknown context")
    func valueForContextCacheMiss() {
        let cache = Style.ValueForContextCache<String>()
        #expect(cache.getValue(for: .any) == nil)
    }

    @Test("getValue returns stored value")
    func valueForContextCacheHit() {
        let cache = Style.ValueForContextCache<String>()
        cache.setValue("hello", for: .any)
        #expect(cache.getValue(for: .any) == "hello")
    }

    @Test("different contexts store independent values")
    func valueForContextCacheDistinctContexts() {
        let cache = Style.ValueForContextCache<String>()
        let contextA = Style.Context.any
        let contextB = Style.Context.any.withAttribute(value: 2.0, for: Style.Context.scaleFactor)

        cache.setValue("a", for: contextA)
        cache.setValue("b", for: contextB)

        #expect(cache.getValue(for: contextA) == "a")
        #expect(cache.getValue(for: contextB) == "b")
    }

    @Test("setValue overwrites previous value for same context")
    func valueForContextCacheOverwrite() {
        let cache = Style.ValueForContextCache<String>()
        cache.setValue("first", for: .any)
        cache.setValue("second", for: .any)
        #expect(cache.getValue(for: .any) == "second")
    }


    // MARK: - AttributeTypeCache

    @Test("getValue returns nil for uncached keypath")
    func attributeTypeCacheMiss() {
        let cache = Style.AttributeTypeCache<Style.Attribute.Number>()
        #expect(cache.getValue(for: \.testNumber, in: .any) == nil)
    }

    @Test("getValue returns stored value")
    func attributeTypeCacheHit() {
        let cache = Style.AttributeTypeCache<Style.Attribute.Number>()
        cache.setValue(.scaled(42), for: \.testNumber, in: .any)

        #expect(cache.getValue(for: \.testNumber, in: .any)?.wrappedValue == 42)
    }

    @Test("different keypaths store independent values")
    func attributeTypeCacheDistinctKeyPaths() {
        let cache = Style.AttributeTypeCache<Style.Attribute.Number>()

        cache.setValue(.scaled(1), for: \.testNumber, in: .any)
        cache.setValue(.scaled(2), for: \.testReference, in: .any)

        #expect(cache.getValue(for: \.testNumber, in: .any)?.wrappedValue == 1)
        #expect(cache.getValue(for: \.testReference, in: .any)?.wrappedValue == 2)
    }

    @Test("different contexts for same keypath store independent values")
    func attributeTypeCacheDistinctContexts() {
        let cache = Style.AttributeTypeCache<Style.Attribute.Number>()
        let contextB = Style.Context.any.withAttribute(value: 2.0, for: Style.Context.scaleFactor)

        cache.setValue(.scaled(1), for: \.testNumber, in: .any)
        cache.setValue(.scaled(2), for: \.testNumber, in: contextB)

        #expect(cache.getValue(for: \.testNumber, in: .any)?.wrappedValue == 1)
        #expect(cache.getValue(for: \.testNumber, in: contextB)?.wrappedValue == 2)
    }

    @Test("keys tracks cached keypaths")
    func attributeTypeCacheKeys() {
        let cache = Style.AttributeTypeCache<Style.Attribute.Number>()
        #expect(cache.keys.isEmpty)

        cache.setValue(.scaled(1), for: \.testNumber, in: .any)
        #expect(cache.keys.count == 1)
        #expect(cache.keys.contains(\.testNumber))
    }


    // MARK: - CacheContainer.resetCache
    //
    // When a Value stores key path references to another attribute, its cache is
    // independent — the referenced value is resolved at access time.
    //
    // When a ValueBuilder uses `builderWrapper` to access another attribute, the
    // resolved result is cached directly, so changing that attribute stales the cache.
    // Surface can depend on Accent this way, so an Accent reset must also reset Surface.

    @Test("within-attribute reference picks up new value after resetCache")
    func resetCacheInvalidatesReference() {
        let definition = Style()
            .appended(numbers: [\.testNumber: .base(.value(.scaled(10)))])

        // Resolve \.testReference — follows .reference(\.testNumber), caches the resolved value (10).
        let wrapper1 = Style.ContextWrapper(definition: definition, context: .any)
        #expect(wrapper1.number(for: \.testReference, scaled: false) == 10)

        // Append a new \.testNumber value — resetCache clears the entire Number cache.
        let updated = definition
            .appended(numbers: [\.testNumber: .base(.value(.scaled(99)))])

        let wrapper2 = Style.ContextWrapper(definition: updated, context: .any)

        // \.testReference re-resolves through \.testNumber and picks up the new value.
        #expect(wrapper2.number(for: \.testReference, scaled: false) == 99)
    }

    @Test("Number reset leaves Padding cache intact — Padding stores Number key path refs")
    func resetCacheNumberLeavesPadding() {
        let definition = Style()
            .appended(numbers: [\.testNumber: .base(.value(.scaled(10)))])

        // Populate Padding cache with `.all(\.testNumber)`.
        let wrapper1 = Style.ContextWrapper(definition: definition, context: .any)
        #expect(wrapper1.padding(for: \.testPadding)?.leading == \.testNumber)

        // Append a new Number value — resets Number cache only.
        let updated = definition
            .appended(numbers: [\.testNumber: .base(.value(.scaled(99)))])

        let wrapper2 = Style.ContextWrapper(definition: updated, context: .any)

        // Padding still resolves to the same key path reference (cache carried over).
        #expect(wrapper2.padding(for: \.testPadding)?.leading == \.testNumber)

        // Number resolves to the new value independently.
        #expect(wrapper2.number(for: \.testNumber, scaled: false) == 99)
    }

    @Test("Surface reset leaves Composition cache intact — Composition stores Surface key path refs")
    func resetCacheSurfaceLeavesComposition() {
        let definition = Style()

        // Populate Composition cache with Surface key path references.
        let wrapper1 = Style.ContextWrapper(definition: definition, context: .any)
        #expect(wrapper1.composition(for: \.testComposition)?.surfaceKey(for: .foreground) == \.testSurface)

        // Append a new Surface value — resets Surface cache only.
        let updated = definition
            .appended(surfaces: [\.testSurface: .base(.value(.color(.blue)))])

        let wrapper2 = Style.ContextWrapper(definition: updated, context: .any)

        // Composition still resolves to the same key path reference (cache carried over).
        #expect(wrapper2.composition(for: \.testComposition)?.surfaceKey(for: .foreground) == \.testSurface)

        // Surface resolves to the new value independently.
        #expect(wrapper2.surface(for: \.testSurface)?.resolvedColor == .blue)
    }

    @Test("Surface reset leaves Accent cache intact — Accent stores Surface key path refs")
    func resetCacheSurfaceLeavesAccent() {
        let definition = Style()

        // Populate Accent cache with Surface key path references.
        let wrapper1 = Style.ContextWrapper(definition: definition, context: .any)
        #expect(wrapper1.accent(for: \.testAccent)?.base == \.testSurface)

        // Append a new Surface value — resets Surface cache only.
        let updated = definition
            .appended(surfaces: [\.testSurface: .base(.value(.color(.blue)))])

        let wrapper2 = Style.ContextWrapper(definition: updated, context: .any)

        // Accent still resolves to the same key path reference (cache carried over).
        #expect(wrapper2.accent(for: \.testAccent)?.base == \.testSurface)

        // Surface resolves to the new value independently.
        #expect(wrapper2.surface(for: \.testSurface)?.resolvedColor == .blue)
    }

    @Test("Accent reset also clears Surface cache — Surface resolves Accent values at cache time")
    func resetCacheAccentClearsSurface() {
        let definition = Style()

        // Populate both Surface and Accent caches.
        let wrapper1 = Style.ContextWrapper(definition: definition, context: .any)
        #expect(wrapper1.surface(for: \.testSurface)?.resolvedColor == .red)
        #expect(wrapper1.accent(for: \.testAccent)?.base == \.testSurface)

        // Verify Surface cache is populated.
        #expect(definition.cachedKeyPaths(for: Style.Attribute.Surface.self).contains(\.testSurface))

        // Append a new Accent value — must reset both Accent and Surface caches.
        let updated = definition
            .appended(accents: [\.testAccent: .base(.value(.init(
                base: \.testSurface,
                onAccent: \.testSurface,
                complementary: \.testSurface,
                contrast: \.testSurface,
                brightness: .dark
            )))])

        // Surface cache should have been cleared by the Accent reset.
        #expect(updated.cachedKeyPaths(for: Style.Attribute.Surface.self).isEmpty)

        // Accent cache should also have been cleared.
        #expect(updated.cachedKeyPaths(for: Style.Attribute.Accent.self).isEmpty)
    }

}
