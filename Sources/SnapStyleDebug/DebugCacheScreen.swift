//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

public struct DebugCacheScreen<KeyType: StyleKey>: View {
    
    @Environment(\.style) private var style
    
    public init() {}
    
    public var body: some View {
        if let cache: SnapStyle.KeyTypeCache<KeyType> = style.cache() {
            List {
                ForEach(Array(cache.keys), id: \.self) { keyPath in
                    
                    section(for: keyPath, with: cache)
                    
                }
            }
        } else {
            EmptyView()
        }
    }

    private func section(for keyPath: KeyType.ValueKeyPath, with cache: SnapStyle.KeyTypeCache<KeyType>) -> some View {

        Group {
            if let valueCache = cache.getValueCache(for: keyPath) {
                let contexts = Array(valueCache.keys)

                Section {
                    ForEach(contexts, id: \.self) { context in
                        item(context: context, value: valueCache.getValue(for: context))
                    }
                } header: {
                    Text("\(keyPath) - \(contexts.count)")
                }
            } else {
                EmptyView()
            }
        }
    }

    private func item(context: SnapStyle.Context, value: KeyType.Value?) -> some View {
        VStack(alignment: .leading) {
            Text(context.description)
            Text(value?.description ?? "")
        }
    }
}

#Preview {
    DebugCacheScreen<SnapStyle.FontKey>()
        .styleOverride(
            fonts: [
                \.title : SnapStyle.ValueBuilder.baseAnd(.definition(.init(size: 6))) { context in
                    switch context.element.hierarchy {
                        case .primary: .definition(.init(size: 16))
                        default: nil
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
