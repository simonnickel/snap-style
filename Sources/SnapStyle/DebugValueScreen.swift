//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleValues
import SwiftUI

public struct DebugValueScreen: View {
    @Environment(\.style) private var style

    public init() {}
    
    public var body: some View {
        List {
            ForEach(Array(style.fonts.keys), id: \.self) { keyPath in

                section(keyPath: keyPath)

            }
        }
    }

    private func section(keyPath: SnapStyle.FontKey.ValueKeyPath) -> some View {

        Group {
            if let values = style.fonts[keyPath] {
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

    private func item(context: SnapStyle.Context, values:  SnapStyle.ValueContainer<SnapStyle.FontKey.Value>) -> some View {
        VStack(alignment: .leading) {
            Text(context.description)
            Text(values.valuesForContext[context].debugDescription)
        }
    }
}

#Preview {
    DebugValueScreen()
        .styleOverride(
            fonts: [
                \.title : SnapStyle.ValueBuilder.baseAnd(.definition(.init(size: 6))) { context in
                    switch context.item.hierarchy {
                        case .primary: .definition(.init(size: 16))
                        default: .erase
                    }

                }
            ],
            surfaces: [
                \.title : SnapStyle.ValueBuilder.context { context in
                    switch context.item.hierarchy {
                        case .secondary: .surface(.withColor(foreground: .primary))
                        default: nil
                    }
                }
            ]
        )
}
