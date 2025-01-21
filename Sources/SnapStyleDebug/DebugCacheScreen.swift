//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct DebugCacheScreen<KeyType: StyleKey>: View {
    
    @Environment(\.style) private var style
    
    public init() {}
    
    public var body: some View {
        let keyPaths = style.cachedKeyPaths(for: KeyType.self)
        if !keyPaths.isEmpty {
            List {
                ForEach(keyPaths, id: \.self) { keyPath in
                    
                    section(for: keyPath)
                    
                }
            }
        } else {
            EmptyView()
        }
    }

    private func section(for keyPath: KeyType.ValueBuilderKeyPath) -> some View {

        Group {
            let contexts = style.cachedContexts(for: keyPath)

            if !contexts.isEmpty {
                Section {
                    ForEach(contexts, id: \.self) { context in
                        let value = style.cachedValue(for: keyPath, in: context)
                        item(context: context, value: value)
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
                \.title : .base(.definition(.with(size: 6))) { context in
                    switch context.element.hierarchy {
                        case .primary: .definition(.with(size: 16))
                        default: nil
                    }

                }
            ]
        )
}
