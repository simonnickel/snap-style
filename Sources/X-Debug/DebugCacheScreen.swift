//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct DebugCacheScreen<AttributeType: StyleAttribute>: View {

    @Environment(\.style) private var style

    public init() {}

    public var body: some View {
        let keyPaths = style.definition.cachedKeyPaths(for: AttributeType.self)
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

    private func section(for keyPath: AttributeType.ValueBuilderKeyPath) -> some View {

        Group {
            let contexts = style.definition.cachedContexts(for: keyPath)

            if !contexts.isEmpty {
                Section {
                    ForEach(contexts, id: \.self) { context in
                        let value = style.definition.cachedValue(for: keyPath, in: context)
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

    private func item(context: Style.Context, value: AttributeType.Value?) -> some View {
        VStack(alignment: .leading) {
            Text(context.description)
            Text(value?.description ?? "")
        }
    }
}

#Preview {
    DebugCacheScreen<Style.Attribute.Font>()
        .styleOverride(
            fonts: [
                \.title: .base(.definition(.with(size: 6))) { context in
                    switch context.element.hierarchy {
                        case .primary: .definition(.with(size: 16))
                        default: nil
                    }

                }
            ]
        )
}
