//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

public struct DebugValueScreen<KeyType: StyleKey>: View {
    
    @Environment(\.style) private var style

    public typealias ItemKeyPath = KeyPath<SnapStyle, [KeyType.ValueKeyPath: SnapStyle.ValueContainer<KeyType.Value>]>
    
    let itemKeyPath: ItemKeyPath
    
    public init(itemKeyPath: ItemKeyPath) {
        self.itemKeyPath = itemKeyPath
    }
    
    public var body: some View {
        List {
            ForEach(Array(style[keyPath: itemKeyPath].keys), id: \.self) { keyPath in

                section(keyPath: keyPath)

            }
        }
    }

    private func section(keyPath: KeyType.ValueKeyPath) -> some View {

        Group {
            if let values = style[keyPath: itemKeyPath][keyPath] {
                let contexts: [SnapStyle.Context] = Array(values.valuesForContext.keys)

                Section {
                    ForEach(contexts, id: \.self) { context in
                        item(context: context, values: values)
                    }
                } header: {
                    Text("\(keyPath) - \(contexts.count)")
                }
            } else {
                EmptyView()
            }
        }
    }

    private func item(context: SnapStyle.Context, values:  SnapStyle.ValueContainer<KeyType.Value>) -> some View {
        VStack(alignment: .leading) {
            Text(context.description)
            Text(values.valuesForContext[context]?.description ?? "")
        }
    }
}

#Preview {
    DebugValueScreen(itemKeyPath: \.fonts)
        .styleOverride(
            fonts: [
                \.title : SnapStyle.ValueBuilder.baseAnd(.definition(.init(size: 6))) { context in
                    switch context.element.hierarchy {
                        case .primary: .definition(.init(size: 16))
                        default: .erase
                    }

                }
            ],
            surfaces: [
                \.title : SnapStyle.ValueBuilder.context { context in
                    switch context.element.hierarchy {
                        case .secondary: .surface(.withColor(foreground: .primary))
                        default: nil
                    }
                }
            ]
        )
}
