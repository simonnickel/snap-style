//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
import SwiftUI
@testable import SnapStyleBase
@testable import SnapStyleComponents

/// Tests for `Style.Container.Stack` — push via `appended(_:state:)`,
/// `current` / `parent` accessors, interaction state, and level tracking.
struct ContainerStackTests {

    // MARK: - Helpers

    private let containerA = Style.Container.Properties("A")
    private let containerB = Style.Container.Properties("B")
    private let containerC = Style.Container.Properties("C")


    // MARK: - Empty Stack

    @Test("empty stack has nil current")
    func emptyStackCurrent() {
        let stack = Style.Container.Stack()
        #expect(stack.current == nil)
    }

    @Test("empty stack has nil parent")
    func emptyStackParent() {
        let stack = Style.Container.Stack()
        #expect(stack.parent == nil)
    }

    @Test("empty stack has nil currentState")
    func emptyStackCurrentState() {
        let stack = Style.Container.Stack()
        #expect(stack.currentState == nil)
    }

    @Test("empty stack has levelOverall of -1")
    func emptyStackLevelOverall() {
        let stack = Style.Container.Stack()
        #expect(stack.levelOverall == -1)
    }

    @Test("empty stack has level of 1")
    func emptyStackLevel() {
        let stack = Style.Container.Stack()
        #expect(stack.level == 1)
    }


    // MARK: - Single Item

    @Test("single item is current")
    func singleItemCurrent() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)

        #expect(stack.current == containerA)
    }

    @Test("single item has nil parent")
    func singleItemParent() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)

        #expect(stack.parent == nil)
    }

    @Test("single item has levelOverall of 0")
    func singleItemLevelOverall() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)

        #expect(stack.levelOverall == 0)
    }

    @Test("single item has level of 1")
    func singleItemLevel() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)

        #expect(stack.level == 1)
    }

    @Test("single item currentState matches appended state")
    func singleItemCurrentState() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .highlighted)

        #expect(stack.currentState == .highlighted)
    }


    // MARK: - Multiple Different Items

    @Test("current returns the last appended item")
    func multipleItemsCurrent() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerB, state: .normal)

        #expect(stack.current == containerB)
    }

    @Test("parent returns the second-to-last item")
    func multipleItemsParent() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerB, state: .normal)

        #expect(stack.parent == containerA)
    }

    @Test("levelOverall reflects total depth")
    func multipleItemsLevelOverall() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerB, state: .normal)
            .appended(containerC, state: .normal)

        #expect(stack.levelOverall == 2)
    }

    @Test("level is 1 when consecutive items differ")
    func differentItemsLevel() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerB, state: .normal)

        #expect(stack.level == 1)
    }


    // MARK: - Level (Consecutive Identical Items)

    @Test("level counts consecutive identical items from top")
    func consecutiveIdenticalLevel() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerA, state: .normal)

        #expect(stack.level == 2)
    }

    @Test("level counts only the uninterrupted run at the top")
    func interruptedLevel() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerB, state: .normal)
            .appended(containerA, state: .normal)

        #expect(stack.level == 1)
    }

    @Test("level counts three consecutive identical items")
    func threeConsecutiveLevel() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerA, state: .normal)
            .appended(containerA, state: .normal)

        #expect(stack.level == 3)
    }

    @Test("level resets after a different item interrupts")
    func levelAfterInterruption() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerA, state: .normal)
            .appended(containerB, state: .normal)
            .appended(containerA, state: .normal)
            .appended(containerA, state: .normal)

        #expect(stack.level == 2)
        #expect(stack.levelOverall == 4)
    }


    // MARK: - State

    @Test("currentState returns state of the current container")
    func currentStateReflectsLastAppended() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .normal)
            .appended(containerB, state: .disabled)

        #expect(stack.currentState == .disabled)
    }

    @Test("state is tracked per container identity")
    func statePerContainer() {
        let stack = Style.Container.Stack()
            .appended(containerA, state: .highlighted)
            .appended(containerB, state: .selected)

        // Current is containerB with .selected
        #expect(stack.currentState == .selected)
    }


    // MARK: - Immutability (Value Semantics)

    @Test("appended returns a new stack without modifying the original")
    func appendedDoesNotMutateOriginal() {
        let original = Style.Container.Stack()
        let modified = original.appended(containerA, state: .normal)

        #expect(original.current == nil)
        #expect(modified.current == containerA)
    }

    @Test("chained appends do not affect earlier snapshots")
    func chainedAppendsImmutability() {
        let step1 = Style.Container.Stack()
            .appended(containerA, state: .normal)
        let step2 = step1
            .appended(containerB, state: .normal)

        #expect(step1.current == containerA)
        #expect(step1.parent == nil)
        #expect(step2.current == containerB)
        #expect(step2.parent == containerA)
    }


    // MARK: - Hashable

    @Test("stacks with same items are equal")
    func equalStacks() {
        let stack1 = Style.Container.Stack()
            .appended(containerA, state: .normal)
        let stack2 = Style.Container.Stack()
            .appended(containerA, state: .normal)

        #expect(stack1 == stack2)
    }

    @Test("stacks with different items are not equal")
    func differentStacks() {
        let stack1 = Style.Container.Stack()
            .appended(containerA, state: .normal)
        let stack2 = Style.Container.Stack()
            .appended(containerB, state: .normal)

        #expect(stack1 != stack2)
    }

    @Test("stacks with different states are not equal")
    func differentStateStacks() {
        let stack1 = Style.Container.Stack()
            .appended(containerA, state: .normal)
        let stack2 = Style.Container.Stack()
            .appended(containerA, state: .highlighted)

        #expect(stack1 != stack2)
    }

    @Test("empty stacks are equal")
    func emptyStacksEqual() {
        let stack1 = Style.Container.Stack()
        let stack2 = Style.Container.Stack()

        #expect(stack1 == stack2)
    }

}
