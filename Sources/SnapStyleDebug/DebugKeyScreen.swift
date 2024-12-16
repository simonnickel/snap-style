//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

public struct DebugKeyScreen<KeyType: StyleKey>: View {
    
    @Environment(\.style) private var style

    public typealias ItemKeyPath = KeyPath<SnapStyle, [KeyType.ValueKeyPath: SnapStyle.ValueContainer<KeyType.Value>]>
    
    let keyPath: ItemKeyPath
    
    @State private var componentType: SnapStyle.Component.ComponentType = .any
    @State private var componentHierarchy: SnapStyle.Component.Hierarchy = .primary
    @State private var itemType: SnapStyle.Item.ItemType = .any
    @State private var itemHierarchy: SnapStyle.Item.Hierarchy = .primary
    
    public init(keyPath: ItemKeyPath) {
        self.keyPath = keyPath
    }
        
    public var body: some View {
        VStack {
            config
            list
        }
    }
    
    private var config: some View {
        VStack {
            HStack {
                Picker("Component", selection: $componentType) {
                    ForEach(SnapStyle.Component.ComponentType.allCases, id: \.self) { component in
                        Text("\(component)")
                    }
                }
                Picker("Hierarchy", selection: $componentHierarchy) {
                    ForEach(SnapStyle.Component.Hierarchy.allCases, id: \.self) { hierarchy in
                        Text("\(hierarchy)")
                    }
                }
            }
            HStack {
                Picker("Item", selection: $itemType) {
                    ForEach(SnapStyle.Item.ItemType.allCases, id: \.self) { item in
                        Text("\(item)")
                    }
                }
                Picker("Hierarchy", selection: $itemHierarchy) {
                    ForEach(SnapStyle.Item.Hierarchy.allCases, id: \.self) { hierarchy in
                        Text("\(hierarchy)")
                    }
                }
            }
        }
    }
    
    private var list: some View {
        let keyPaths = Array(style[keyPath: keyPath].keys)
        
        return List(keyPaths, id: \.self) { keyPath in
            KeyType.row(keyPath: keyPath)
                .style(component: componentType, hierarchy: componentHierarchy)
                .style(item: itemType, hierarchy: itemHierarchy, applyStyle: false)
        }
    }
    
}

extension StyleKey {
    
    @MainActor
    @ViewBuilder
    static func row(keyPath: ValueKeyPath) -> some View {

        // TODO: Is there a simpler solution without casting?
        switch self {
            case is SnapStyle.FontKey.Type: DebugKeyRowFont(keyPath: keyPath as! SnapStyle.FontKey.ValueKeyPath)
            case is SnapStyle.SurfaceKey.Type: DebugKeyRowSurface(keyPath: keyPath as! SnapStyle.SurfaceKey.ValueKeyPath)
            default: Text("Test")
        }
        
    }
    
}

#Preview {
    DebugKeyScreen(keyPath: \.surfaces)
}
