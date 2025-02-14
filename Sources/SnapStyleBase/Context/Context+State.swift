//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle.Context {
    
    public enum StateAttribute {
        case disabled
        case selected
        case highlighted
    }
    
    public var stateAttributes: Set<StateAttribute> { getValue(for: Self.stateAttributes) ?? [] }
    package static var stateAttributes: Attribute<String, Set<StateAttribute>> { .init(key: "stateAttributes", valueDefault: []) }
    
    public var isSelected: Bool { (getValue(for: Self.stateAttributes) ?? []).contains(.selected) }
    public var isHighlighted: Bool { (getValue(for: Self.stateAttributes) ?? []).contains(.highlighted) }
    public var isDisabled: Bool { (getValue(for: Self.stateAttributes) ?? []).contains(.disabled) }
    
    public func with(state: StateAttribute, value: Bool) -> Self {
        var current = getValue(for: Self.stateAttributes) ?? []
        
        if value {
            current.insert(state)
        } else {
            current.remove(state)
        }
        
        return self.withAttribute(value: current, for: Self.stateAttributes)
    }
    
}


// MARK: - ViewModifier

extension View {
    
    /// Set value of a `Context` attribute for use in Environment.
    public func style(state: SnapStyle.Context.StateAttribute, value: Bool) -> some View {
        self
            .modifier(ContextStateModifier(state: state, value: value))
    }
    
}

internal struct ContextStateModifier: ViewModifier {
    
    @Environment(\.styleContext) private var context
    
    let state: SnapStyle.Context.StateAttribute
    let value: Bool
    
    func body(content: Content) -> some View {
        let modified = context.with(state: state, value: value)
        content
            .environment(\.styleContext, modified)
    }
    
}
